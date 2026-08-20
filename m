Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28577C5DF82
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Aug 2026 18:48:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8F0F710E21A;
	Thu, 20 Aug 2026 18:48:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="EGkzm00m";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012061.outbound.protection.outlook.com
 [40.93.195.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A716D10E21A
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Aug 2026 18:48:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SX7dPAjYjtyVViQnUbz7e/TzXclYz42NOoiXvAe8T6A2wVooe5JtegSBsoZ4sFYjekqIrB3InEVKmaK/oG3ZM1InlcHfkG0wOG9CcWSaWuKz2yMhunq8Ykhjq+haInxS3DQ1XObiUcCFzL4DSBmzte2CSowPJDQt06FDji6yeimuCXT/FNXebGFsC5ax1i91YlgzMbzE8dUyBFMChBZt+9HuS5kg6nbcS5F75sV/hGmqzTD0ISuLylxKwfpK8Yqr3Sp3YLhKiXiWjdTZqDnVlaw49YuZf8K5eUp70c7iA51BsCZcuwBtdSnEKtr+rzeJyFtALMFyYC6lKYzcR4yzgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kyER0ryyQsOuGYyfoi9cCnyuIs5UYVrKxT7rvajS8kI=;
 b=QWZqJPHSndyLgiUfWWbeAGFL426cd7wsQBk7yNpbnoA/GDm+sTCMcGVJcxo0JQjrIWlWOYqChhgHWhtcwd/T8FkiRncsjUa0+vD3NKczftQyPgM3HRTPPdiEhNFNBKGJIbSIwrhGK2JJ+tNZwN7w3XIQHeBz0IuCp8riNIEJomsNBMnsU3lBrkdRkTBHLTBts/vYEYrDeLTD6DxdLNBVV8KKPRDUAmarwTVKb89vn8gLzvSKhVTafumiqsDI1+2nlLqsi33klMZVoS69+kPPjGAQcqqRnUqL+Mt0Wpf89bUCxqd3vt5coAElU0gGOLyiMyL7CvJjFfc6LC5Z+dDPbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kyER0ryyQsOuGYyfoi9cCnyuIs5UYVrKxT7rvajS8kI=;
 b=EGkzm00mu8mFi9V48UNOUJns+y4Z84ozwsoByEZgHrHBNT0uV2RHlYXK1ziv2gLtoL9gvTEC/ZqOGnCDczJX4jxF1SuAXq1qi1yuM5ie4HEx0moTDMbJjO6HjgKiloeyMJGjYIlNFSGj7NDgYxN5+vj4TnObGGAYHPlah5zwOqs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA1PR12MB6970.namprd12.prod.outlook.com (2603:10b6:806:24d::5)
 by MW5PR12MB5684.namprd12.prod.outlook.com (2603:10b6:303:1a1::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.11; Thu, 20 Aug
 2026 18:48:34 +0000
Received: from SA1PR12MB6970.namprd12.prod.outlook.com
 ([fe80::a65f:48fc:86fb:e958]) by SA1PR12MB6970.namprd12.prod.outlook.com
 ([fe80::a65f:48fc:86fb:e958%4]) with mapi id 15.21.0315.016; Thu, 20 Aug 2026
 18:48:33 +0000
Message-ID: <9e637983-d315-443e-9424-ac51932b2ca4@amd.com>
Date: Thu, 20 Aug 2026 14:48:32 -0400
User-Agent: Mozilla Thunderbird
From: george.zhang@amd.com
To: amd-gfx@lists.freedesktop.org
Subject: Re: [PATCH] drm/amd/display: Fix redundant GPUVMEnable checks in dcn6
 flip schedule
References: <20260820101601.3942853-1-srinivasan.shanmugam@amd.com>
In-Reply-To: <20260820101601.3942853-1-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0094.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:4::27) To SA1PR12MB6970.namprd12.prod.outlook.com
 (2603:10b6:806:24d::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR12MB6970:EE_|MW5PR12MB5684:EE_
X-MS-Office365-Filtering-Correlation-Id: 01b043b4-c1c7-4356-7836-08defeeba2df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|376014|1800799024|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: ozfw/nHnTZlUtaJVUJbCQBpi6rCpdKgo9KDiyR9mSuu+qsPbKcK3e2BSlP0FqEryoBnrqfCr/qURqd/zCiK+Su33ZtBLXfWLc8vr5k+KOTN6Tl18as/4kU8+gA1cAEP79yv28vAS9lgtYYxsniS6DkXIecXs3oHO/XoooykYvXUa/x27gJQLVtu4jZO8mZOlRHL4bsv4TX3GpAURql/36/13Ogw3cz6p+jmznObmspa60Lx7HnwpTuAARWEX5ggdvt6bx9HDehaI/5u6/yFircpSHqlYTqKc+6kPMpB3Q2jbcjYabrWo47UeUBPA9K0BoHJ4y6/QDhGCo8bmkS2Q3GokJxAAb4dwh27F8M70UOgg/9L48KDzwJpfJdaQl6N7bwezj9BfhaM7XfwnzDAWfZq1UxKEUD0GO7UW9FWxF3GTDdmZIGoziKv7VXCz5TJ8fq1iefPt/CuDMtfdIzxWjfGGZb96ML4hIb6h0RfR6vVb5KZQK/D7AjHct1OHRW7bv8xz1d00Ur/6cqAPP75KxGt4lwrrL3qJ+ddVw26Vfte6MvZr4g6UYJR3Gj3s5XSCBxb9z3SrkGrvJ3TDwbjIXmriLW9asYknDNQAQ/tfqaB8sE3YPFqDTcjm099XFcDd+ijXbaN4RMeY+hxjQqsO0Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR12MB6970.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V1lwNzZIN3JXVnRjMXRUS042MWp5ektKSHNCb0F6c3N5ZE54VjhRVkFMQUJ1?=
 =?utf-8?B?eW4zcTBJZ0RiclVJVXQrQkhqQ3Y4OEVGTkdVd2pzd0J5TW5WeDFBRVVJRU5i?=
 =?utf-8?B?b0hlYWFyZmxrNkhOWlNKSnhhbnM2OXQ1R1NDVjdXdSt6YnpuYXFyaG5maWx6?=
 =?utf-8?B?b1o2NHpzenRsYmx2VHdndGY3RDRXcFZvckp5YWIyUytIRzZnUU05MWcrNGI2?=
 =?utf-8?B?NDN3blQ1VW11R2NjemxoUzBEUkdHRERENlFZS0c1Y3h1Z3hkTnRlQTcwQWVF?=
 =?utf-8?B?cXljRGFBT3JpdFpaenU0WHhyZzAwQWZ2YzhCQXhqcCtZWmFjRE5ad1U1b0pQ?=
 =?utf-8?B?djUyMm5QSHhXbnMvemV2YTlnMGRRbi90NExvcDVrZTdMRUMrOWtGMkhtczJl?=
 =?utf-8?B?RGN2TGVsZXZ1QzFUdTVkY2YxRGJIeWNLcTNEWVZwMERESng3NVMralNOWjA0?=
 =?utf-8?B?djVvL0xpaGxSeVJDeVZGeTN4SnBBeTNTVm81Ty9ORllSVy9MOUpNd1IzRlFJ?=
 =?utf-8?B?U25hNkt2dmlBMFlqbWEvV2xxMjM1MWRla1ArcjJkTWVuNVlPVERoYU0xV0RN?=
 =?utf-8?B?N1FRRXJtYzVkMjFZMmphN1BRSk5DTWZDMGxLY1pwbVZtQmFHaXA2QWJsK0Zy?=
 =?utf-8?B?UGdCdEJvdS8yUHF5OVdsV1ZIUWViL2NaYkpQY01QUnhLRmZCUXpqOVI2YklZ?=
 =?utf-8?B?NVZGVG5rTlBUdjJVOUx6L290eEZIRzZraVBHbGtyclhmQTA1WUFIQWJXSnZX?=
 =?utf-8?B?dEIyUHNoVVFIc08zdlpKVUIyNHFnL2IzMWwzOFFSdkIwdE9YWlRxamE4NlhY?=
 =?utf-8?B?WEw4dGtCckRXc0Q4T1Y1TUwvV3VDQWJ6T2oyUkw2MTlkc3c2REdXWWlxYk1M?=
 =?utf-8?B?ekY0U2xweXcrYVMwQklDMGpTTFplZ2h1SjJhYm8zSXJGbTBHVmxLK21NSU1I?=
 =?utf-8?B?VDFQaCtpbTRZR3Z1L1JNdE5aeVVpRjJjQXFmM01yVFNoUFgxZ3IrVlJKOTUy?=
 =?utf-8?B?USs4MmdUNVFobnBLMCtkWVE2a0FqTWFpeVhlTnM4MlhpUEhnYjRkYXNOZUlY?=
 =?utf-8?B?UndzdG9wVUp2c0dJYmVHbU80RnVtRzFvK3lmdTJmdWhMZ1UwUmFEUytjR1ow?=
 =?utf-8?B?eStsZDNqZ0hPUG05VDBkYThiRFNaUUlDaDR4VnNLTmtFUkY1SnRIQzJuTzA4?=
 =?utf-8?B?aUNXYnd5SmZ4RjV2dlV5UzdLeklpR0lKaFJKaXZxSWhzclB2clNtVFJwNnZH?=
 =?utf-8?B?bVFGaVp6bDRIZ1JEMEZIOTlHcjhQUjdhOTJ5N3FjZ0s4UXFOTUMwZW1tRVVX?=
 =?utf-8?B?ZkM1RUJwbVFncWVxc3M4UGkrZTFJSFROK1B4Smh4VzNVZjVHQWFGT240amF6?=
 =?utf-8?B?QkFUTlk0dHYyWmh5NWpVRVFPQ2c4YUNlckJ3MmJiVnJUR0NzODJDREMwMFUz?=
 =?utf-8?B?UjBjdXdIUlludDBxVWROeDVWVE5PSFlYQUZDazcrZ2UzdERPdmlodXRZZyt5?=
 =?utf-8?B?TTBhOHRNdjRNcEtrOVpSZjMweWhXTW5CQ2VNLzhhOGRKdEJXOWd5L1UwZnUw?=
 =?utf-8?B?SEt0NGp5ZXNSS2hUT0F3Qll0QytSN2ZIdE5nazVka1VYSkVkR1VYdk5VQjJZ?=
 =?utf-8?B?N3lhQnRBaWZBTUt1S1poRTJBZi8raElZMndCVlp1YWhreTg0aGs3YjNTUmZU?=
 =?utf-8?B?UW5uK2hYaHVXYzR3SlQ2ejZnTDN4Vmp6SDR1WDBWMTd0dFpwZkJQbkhuamM4?=
 =?utf-8?B?VWJTVUZKcGM5dVQ1Q0JLYUJ2eFNwa0pzYm84Kys3aHh0RENmb2VrQ0hscm45?=
 =?utf-8?B?WmpKUmx3d2Y0UGtMR2MzRnVmbEtTbyszU2FkdWFhUTY5V3FDQ0tkWkVYZ3BJ?=
 =?utf-8?B?RDYzZ1NlTjE0VkNLcm5pd0lxZkEvRjFRdWRPcHRUMFBzNGZxRCtVdEZVZUxr?=
 =?utf-8?B?RWUvaldMWS8zYTNDKzdEQ1FQWDQ5ZTZ4WTF0QkN5RW1lYzFRRlB6RjN3Qmh0?=
 =?utf-8?B?UHdrbEJvZVZVWUNlMVdGSnZyZ2FMeU53QzlwVVpoZGw2SEpEdjRjYmpzME4r?=
 =?utf-8?B?YkNjaEVJbTlWa09FQ1Q4NHBzK0NBa1NJalU2SzBKejRDb2dYN0hEM3VDT3dN?=
 =?utf-8?B?Sm9pVWVweUpFMk0rNkdzK2piaElYbmtrY3U3R1BLbmNWQ2M3TGxlNEVrdnJB?=
 =?utf-8?B?TE51c2lZa29Xd0RYWmVuN0gzT0ZRQlQvNVRkaVpPY3dCZjNQalZ6VklxS0pi?=
 =?utf-8?B?ZzBhVlZyc1hNem5FTlVpQXUvTkt5VTlBdnJKaGRjZ1kyRzFUSlV2RXo0NThm?=
 =?utf-8?B?aG5lT2FZd3FQSEdsZzhlcDZ3ejhST1JjNldVdEViSDNENGplaFR1UT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01b043b4-c1c7-4356-7836-08defeeba2df
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB6970.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2026 18:48:33.8835 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fVAthBxXxFvIH4Zy7YKbi0wLQ8VuFCtIZHbVOyJ5nE54B2yR/9ufllXwOTv7Q5kBpTAlAin2WBHvPz/NY8102w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5684
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



On 8/20/26 6:16 AM, Srinivasan Shanmugam <srinivasan.shanmugam@amd.com> wrote:
> Inside dcn6_calculate_flip_schedule(), GPUVMEnable is already checked in
> the outer if block. But the same GPUVMEnable is checked again in two
> inner if blocks inside it. Since GPUVMEnable is always true at that
> point, the inner else branches that assign meta_row_height are never
> reached.
> 
> Remove the redundant inner GPUVMEnable checks and directly assign
> dpte_row_height, which is always the correct value here.
> 
> Fixes: 04d9a88decbc ("drm/amd/display: Add new sources for DCN6")
> Reported-by: Dan Carpenter <error27@gmail.com>
> Cc: Roman Li <roman.li@amd.com>
> Cc: Alex Hung <alex.hung@amd.com>
> Cc: Tom Chung <chiahsuan.chung@amd.com>
> Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>

Reviewed-by: George Zhang <george.zhang@amd.com>

> ---
>   .../src/dml2_core/dml2_core_dcn6_calcs_dchub.c    | 15 +++------------
>   1 file changed, 3 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn6_calcs_dchub.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn6_calcs_dchub.c
> index cae6bee93fe3..a4e2f8604650 100644
> --- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn6_calcs_dchub.c
> +++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn6_calcs_dchub.c
> @@ -569,20 +569,11 @@ void dcn6_calculate_flip_schedule(
>   
>   	if (GPUVMEnable) {
>   		if (l->dual_plane) {
> -			if (GPUVMEnable) {
> -				l->min_row_height = dpte_row_height;
> -				l->min_row_height_chroma = dpte_row_height_chroma;
> -			} else {
> -				l->min_row_height = meta_row_height;
> -				l->min_row_height_chroma = meta_row_height_chroma;
> -			}
> +			l->min_row_height = dpte_row_height;
> +			l->min_row_height_chroma = dpte_row_height_chroma;
>   			l->min_row_time = math_min2(l->min_row_height * LineTime / VRatio, l->min_row_height_chroma * LineTime / VRatioChroma);
>   		} else {
> -			if (GPUVMEnable)
> -				l->min_row_height = dpte_row_height;
> -			else
> -				l->min_row_height = meta_row_height;
> -
> +			l->min_row_height = dpte_row_height;
>   			l->min_row_time = l->min_row_height * LineTime / VRatio;
>   		}
>   		DML_LOG_VERBOSE("DML::%s: min_row_time = %f\n", __func__, l->min_row_time);
> 
