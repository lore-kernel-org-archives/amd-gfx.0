Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59EF1C001DF
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Jul 2023 05:22:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C3D7610E642;
	Fri, 28 Jul 2023 05:22:43 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5F25C10E012
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Jul 2023 05:22:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NXLLZO74exE3DOfPhDqgJfkHjmm9fpm0ft/G4P0+dAKy26XI6G7EXn0/6ibASoH0bZ3GAgS8jQjzOWoq0RTl4V/QK5kP8AaaQDTjU/UZiXBJSbO8xfrW5Hw2FXg6ZKXsN8kBBgNf3RGj6EvskLkDr0Q+sQVtkgzTdmr9ETOJ8yydW01U8fWpbPaPHlsDXs2s2/pNGamMZBwlrTn6YE7i8dveoRm0ukktZRpF2/QX8maOJLD79FsSxV85rgrd4W1BEtXA114Hjj2VpqfbCLCpjCFsI0fzpzQSDHgXm5iQTlJop5tYszLFN7kuOqqYsQs956/CBWVIHOz5Ynj6L1E8oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m8hdLksfh32eFZmMy6agvZeOKcy413j27UnF9+wv3es=;
 b=eIxxI4d0PI+HhwSLKu1AGAEW/lsw18Ol7f8EO969qmd33umXXKwYuhiLrPVNq6CnOUQ9RaLNpz/CMU86lh4BuGJmH9jb18hJzpB3iH6YVIYFojqSabhTqZqzyg7tamGXU523nXb0HhG+Kv4JA4ksoQFv2/IRkedpoieEXVdm+q68UfkAsN/6XbXY1Um8VZxlJ2P99Wm4074B4dFFvKWQsBv/wbgGiqMrOLhkUcwCEVtF1xiDw2CvBMlVzqO8hP8lxuEPyEh/ntAHz+Kkkr+yO0JKyu+NSwd6BBmcyMVrz9nrVRLdSBFJ9a4BPX13dgdEMz+5RbFzyN4hjFpe0qaeew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m8hdLksfh32eFZmMy6agvZeOKcy413j27UnF9+wv3es=;
 b=WvENB7XXtKucMQyTebCJeJS3pyRurtVjHLPWDo0Zwv7dbIaYF4c0JNrG+O7j6YyowhYCPhwb0LhJwIlIrOQwbzgdsrQDoS7X1ptnKAClg2l9MYxiuW6IModEqdlhLiutDtOdlxF/xqNQRqhRQr75Q6lw20JD7h1O5nTfMAIcPZw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by BL1PR12MB5240.namprd12.prod.outlook.com (2603:10b6:208:319::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Fri, 28 Jul
 2023 05:22:38 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::bd4b:829f:c0b1:bad6]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::bd4b:829f:c0b1:bad6%4]) with mapi id 15.20.6631.026; Fri, 28 Jul 2023
 05:22:38 +0000
Message-ID: <827537f5-9b51-89f8-744e-61da3e455a18@amd.com>
Date: Fri, 28 Jul 2023 10:52:23 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH 3/8] amdgpu/pm: Optimize emit_clock_levels for arcturus -
 part 2
Content-Language: en-US
To: Darren Powell <darren.powell@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230427062718.1172269-1-darren.powell@amd.com>
 <20230427062718.1172269-4-darren.powell@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20230427062718.1172269-4-darren.powell@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN0PR01CA0006.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:4f::11) To BYAPR12MB4614.namprd12.prod.outlook.com
 (2603:10b6:a03:a6::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4614:EE_|BL1PR12MB5240:EE_
X-MS-Office365-Filtering-Correlation-Id: c2632c1d-cd2b-4447-208b-08db8f2aa822
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZWeI0c0AY2Mv3IXZVCrFXCfZdTfb4eko+KezolnUoI/f93JIAtoP4IWhL/LU8xzlazFjM0gnyjZY34TVCasadqcoo9CGnkkjb4nVF5tAStBsQGWldzrZzJOuhbuqeT0mdgjxbBgq3q2G5G6RB0iTnQEHWz4pvlR2zBi6F4u9DF90FxCl+nVmWBjT3yIX+mAEVw6OSwevjLIn2G6HTYp2iC6A6RP7DaC5lEy/3koWZbi6BkWVBcrwZptPpZJTsDa0F99Rj2jWt9jlXfr2rjgPGz32pZMAaxih4WDN7WmZa6ylxP7x8KP5bvyrtcEXdegLDMMIrHT26Ja+aJ4lY8c7EAnJfPyQ69LFMFNsy3f8GFTPOAxFucqQoPjldodcofqYnBILRaY2iGAcU/kroq/6xnZQJtIdJJdsY0fLqux7kjUHLoWjMqEVryPWgGRZP0mNqMw+P9DcDkX+1glg2PXNnSelBw20SoUgdXa5QYWUqsYVWpy/KwWJhobzivRCoWXAuoWfxmyrGSvEM+i2iKvKYx2ehX4nfdEgDSt8IAuxyHPd7MQhMiwHBP1k4BC0AC/uzbs3qLDuVmJEfczxaNS+9b10/dqwUByPpoQMlO8T9jjXDTaVNeJ/pLO8+ZX+R+0cFK3r4MrpYgkZ4HRoUsAM4g==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(376002)(396003)(346002)(136003)(366004)(451199021)(5660300002)(478600001)(31696002)(66946007)(38100700002)(316002)(6506007)(4326008)(66556008)(66476007)(26005)(6666004)(53546011)(186003)(6486002)(6512007)(8936002)(8676002)(2906002)(41300700001)(2616005)(36756003)(86362001)(83380400001)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?alJVYkJZYkw0Vmd5STlOdENQTnM1WjdKWlFYV1g2NHdYVmZKS09KbkhLOXhD?=
 =?utf-8?B?VEwvS25SSG03WnN0Z2xucXhKRGN4V3VoVDlYS2JSZDVwYXBEY3BDZUtxVEZW?=
 =?utf-8?B?WTFyRVpNcmltQ01CaWVoYjBVeFphMkN6UVNMQkFGT1phWktYWGM4VmtPQmgy?=
 =?utf-8?B?WGNCVXlsVU1CbDhhSXlTdTZuenJtaXc2SkNhTVQ1OTBKWlFMK0lQRjdoMS9h?=
 =?utf-8?B?TjVFbEI0YnhML0FlSW5xOGkva1dmc1dlL1NpdXhjdkJjV1pJM25NODJqcTZY?=
 =?utf-8?B?RkErdzdWajFsYVNKMTVtWTh5eHFUMUdLekdSQi9lQnkzd2hmNWhrWVdlSUto?=
 =?utf-8?B?eHBnS3RpekNOV21qYkQ5ZkthYXZTaUZteWlTZVJpUjFPd3BvZzNkeDJFZmxM?=
 =?utf-8?B?VVgzWVZLckRDNjFFMjZxZEUrOHdiVHRNTDJRdTltdTZDSzk5dVZYTzlyUVQ0?=
 =?utf-8?B?Sk5xd3JseW1hZmpCQzlFMEZlNTVtRVFQb0hYSTl3dXpJOGpyZEF4WWxMNEFZ?=
 =?utf-8?B?Um5QOTBOUmV4RTVZTHhYaEhHM1VVczNlYk1VNFRwcDduUlBlWWlSV2RYRnV2?=
 =?utf-8?B?WVlkZjNycXlrQVV2dUZsajI1U2VXbTllZ2wrYzRUb1dkVHBTNjdFWGp2UkxR?=
 =?utf-8?B?UWtuV2VwYXBqcXNqVmtId01pUFJKQlVJS2JaY0E5OWNnTFFPUE9iWTU1WmVy?=
 =?utf-8?B?WFFmYVBOY04xa2JNRkRLR0RvMkNXcmtIMXpxVFUwZEdtRmZIV201NnlFR1FQ?=
 =?utf-8?B?ZXlQaUlKaWJTRzYzNmZMNWxza1JGNEhrSFJUTExlUXlLYTVqSE5sU2ZXUUFJ?=
 =?utf-8?B?eUp4MlRsMTFiMWNaamRpNnh0Vyt3SUhVS1UxeE5wa1pQdStRMUo0QmhkbXdr?=
 =?utf-8?B?blkzSndlZmZ0UlpGZ3d1bFBrUEpIZDZtaVU0YU5uZHU2YU1sS21ncjJoc3JE?=
 =?utf-8?B?SEZUYno3bTl2eW95TmxiTnIwTnhUOGNZc1hjNEp3NTdobGlsTFZIOWd0T1pJ?=
 =?utf-8?B?U2VPTFhlS2srSmU3N0VDN0tJL292OHdraE9WNlI0MnZUV3FWalh5NUxIQ3lY?=
 =?utf-8?B?WFNoQmJDMVJmcHlpMXdrYlJtSEhrT3NaNDduWjJVOUZNRHFuNnQ5WmxhWjdT?=
 =?utf-8?B?MnIwNlJYZ0xtbE5kanFTNWJiN3BaWmVYVUxKODk3NWZ0K1lrclRFeUErMHdC?=
 =?utf-8?B?WnJCYlh6UEVLbE51QWNTTjlMRHZZTFBYYlZpbUJ4cEdVNURRcGRmTDdvNnRW?=
 =?utf-8?B?M0ZNRDlHOEx3OGpndzdiRm1EMHNCeFIrOWJDcXBHeTVuTWZJUWtHT2hreW5G?=
 =?utf-8?B?T3k3dExHNUV6UExicHJCK0JrcTNHcTZXTXpycHNOVE8vWFVTNWpGVEM1b2gw?=
 =?utf-8?B?MTNiSXFSOVBwWkxieFdRbDgrRTZWaG5xWjFFWTU4ZEMzemdSWElxQmZ2RDBF?=
 =?utf-8?B?TWtIN1lKZ3ZJL0dQR3dTVGRVZ2RIOHc2Z1VqdUZTM2tuN1k1SlRXUE52QXUw?=
 =?utf-8?B?cWI1aUNsM1J2cWFkeDAxWW5kR2N2S2hDNHYySFMvbXhoeHRYWGFyMHMxZGVu?=
 =?utf-8?B?WEhBZWdSOWZ6OEQwNjJNakZhNkxvS0d1ZHhuSnhXZU55UTh6UVAzdldPZ2xZ?=
 =?utf-8?B?VmtPVWROTnRhOXZjK3dvazQ3Z0tFRGVSVWJhempYRGViRDAvZjZLT1k0a21q?=
 =?utf-8?B?dmxYTFpTR1FybW5mcjMrd29BYnpDNmdCSUFyYUZVL2M2VHZoaFZKZkJ0eEg1?=
 =?utf-8?B?aXE4WUhCMzNMWTZPanAxV0ZwZ0YwbC9MeFhLb1JDMStCZFJUTmhTOXlpMGoy?=
 =?utf-8?B?YXNQeGVYT20zMjJtVXNZR2JQV0h3Q0JmYU1UeTh5aTZ0RXVJMTkvVVN3TWpL?=
 =?utf-8?B?Mmc2MWNnMXJ4S0FNeW0rYnNCTnFyTzZROUY0Y0RjTnNDN0syazJwM0lDM0pS?=
 =?utf-8?B?b2VSWUJBdU9GQ3N6RWM4T3c5TVJIa294UkdzT29DUWhETmpaR3EzQmNaakVW?=
 =?utf-8?B?T2VLbk5WZTRBbDV6UFA1RkxKdjR2WnVKSEpNMUxnT3hISXVVZDhMbWNEWHhT?=
 =?utf-8?B?NnpiZzdhQS9pL255K0FXNUdkTkE2MHQ2K3ZKSDJCWjJsdm1UdnBtQUFNa1J5?=
 =?utf-8?Q?HVwQuDSCRi0F2KHLKPiDy2Cbh?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2632c1d-cd2b-4447-208b-08db8f2aa822
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2023 05:22:37.9547 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4MED8iRxOX+09XBKbb26sIk+YcpvfCYyfOvh/0JamxijyK+ER1WPjozeouSd0pqv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5240
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
Cc: ray.huang@amd.com, evan.quan@amd.com, lang.yu@amd.com, david.nieto@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 4/27/2023 11:57 AM, Darren Powell wrote:
>   Use variables to remove ternary expression in print statement and
>   improve readability. This will help to optimize the code duplication
>   in the switch statement
>   Also Changed:
>    replaced single_dpm_table->count as iterator in for loops with safer
>      clocks_num_levels value
>    replaced dpm_table.value usage with local var clocks_mhz
> 
> Signed-off-by: Darren Powell <darren.powell@amd.com>
> ---
>   .../gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c | 45 +++++++++----------
>   1 file changed, 22 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
> index 23e768aad6f9..aea78f9dbae2 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
> @@ -794,11 +794,11 @@ static int arcturus_emit_clk_levels(struct smu_context *smu,
>   		for (i = 0; i < clocks.num_levels; i++) {
>   			clock_mhz = clocks.data[i].clocks_in_khz / 1000;
>   			freq_match = arcturus_freqs_in_same_level(clock_mhz, cur_value);
> +			freq_match |= (clocks.num_levels == 1);

<Nit> You may use it with || in the previous expression to get short 
circuit benefit.

Thanks,
Lijo

>   
> -			*offset += sysfs_emit_at(buf, *offset, "%d: %uMhz %s\n", i,
> -					clock_mhz,
> -					(clocks.num_levels == 1) ? "*" :
> -						(freq_match ? "*" : ""));
> +			*offset += sysfs_emit_at(buf, *offset, "%d: %uMhz %s\n",
> +						 i, clock_mhz,
> +						 freq_match ? "*" : "");
>   		}
>   		break;
>   
> @@ -815,11 +815,11 @@ static int arcturus_emit_clk_levels(struct smu_context *smu,
>   		for (i = 0; i < clocks.num_levels; i++) {
>   			clock_mhz = clocks.data[i].clocks_in_khz / 1000;
>   			freq_match = arcturus_freqs_in_same_level(clock_mhz, cur_value);
> +			freq_match |= (clocks.num_levels == 1);
>   
>   			*offset += sysfs_emit_at(buf, *offset, "%d: %uMhz %s\n",
> -				i, clock_mhz,
> -				(clocks.num_levels == 1) ? "*" :
> -					(freq_match ? "*" : ""));
> +						 i, clock_mhz,
> +						 freq_match ? "*" : "");
>   		}
>   		break;
>   
> @@ -836,11 +836,11 @@ static int arcturus_emit_clk_levels(struct smu_context *smu,
>   		for (i = 0; i < clocks.num_levels; i++) {
>   			clock_mhz = clocks.data[i].clocks_in_khz / 1000;
>   			freq_match = arcturus_freqs_in_same_level(clock_mhz, cur_value);
> +			freq_match |= (clocks.num_levels == 1);
>   
>   			*offset += sysfs_emit_at(buf, *offset, "%d: %uMhz %s\n",
> -				i, clock_mhz,
> -				(clocks.num_levels == 1) ? "*" :
> -					(freq_match ? "*" : ""));
> +						 i, clock_mhz,
> +						 freq_match ? "*" : "");
>   		}
>   		break;
>   
> @@ -854,14 +854,14 @@ static int arcturus_emit_clk_levels(struct smu_context *smu,
>   		single_dpm_table = &(dpm_context->dpm_tables.fclk_table);
>   		arcturus_get_clk_table(smu, &clocks, single_dpm_table);
>   
> -		for (i = 0; i < single_dpm_table->count; i++) {
> +		for (i = 0; i < clocks.num_levels; i++) {
>   			clock_mhz = clocks.data[i].clocks_in_khz / 1000;
>   			freq_match = arcturus_freqs_in_same_level(clock_mhz, cur_value);
> +			freq_match |= (clocks.num_levels == 1);
>   
>   			*offset += sysfs_emit_at(buf, *offset, "%d: %uMhz %s\n",
> -				i, single_dpm_table->dpm_levels[i].value,
> -				(clocks.num_levels == 1) ? "*" :
> -					(freq_match ? "*" : ""));
> +						 i, clock_mhz,
> +						 freq_match ? "*" : "");
>   		}
>   		break;
>   
> @@ -875,14 +875,14 @@ static int arcturus_emit_clk_levels(struct smu_context *smu,
>   		single_dpm_table = &(dpm_context->dpm_tables.vclk_table);
>   		arcturus_get_clk_table(smu, &clocks, single_dpm_table);
>   
> -		for (i = 0; i < single_dpm_table->count; i++) {
> +		for (i = 0; i < clocks.num_levels; i++) {
>   			clock_mhz = clocks.data[i].clocks_in_khz / 1000;
>   			freq_match = arcturus_freqs_in_same_level(clock_mhz, cur_value);
> +			freq_match |= (clocks.num_levels == 1);
>   
>   			*offset += sysfs_emit_at(buf, *offset, "%d: %uMhz %s\n",
> -				i, single_dpm_table->dpm_levels[i].value,
> -				(clocks.num_levels == 1) ? "*" :
> -					(freq_match ? "*" : ""));
> +						 i, clock_mhz,
> +						 freq_match ? "*" : "");
>   		}
>   		break;
>   
> @@ -896,14 +896,14 @@ static int arcturus_emit_clk_levels(struct smu_context *smu,
>   		single_dpm_table = &(dpm_context->dpm_tables.dclk_table);
>   		arcturus_get_clk_table(smu, &clocks, single_dpm_table);
>   
> -		for (i = 0; i < single_dpm_table->count; i++) {
> +		for (i = 0; i < clocks.num_levels; i++) {
>   			clock_mhz = clocks.data[i].clocks_in_khz / 1000;
>   			freq_match = arcturus_freqs_in_same_level(clock_mhz, cur_value);
> +			freq_match |= (clocks.num_levels == 1);
>   
>   			*offset += sysfs_emit_at(buf, *offset, "%d: %uMhz %s\n",
> -				i, single_dpm_table->dpm_levels[i].value,
> -				(clocks.num_levels == 1) ? "*" :
> -					(freq_match ? "*" : ""));
> +						 i, clock_mhz,
> +						 freq_match ? "*" : "");
>   		}
>   		break;
>   
> @@ -926,7 +926,6 @@ static int arcturus_emit_clk_levels(struct smu_context *smu,
>   
>   	default:
>   		return -EINVAL;
> -		break;
>   	}
>   
>   	return 0;
