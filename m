Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4947C001E0
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Jul 2023 05:27:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5941410E051;
	Fri, 28 Jul 2023 05:27:06 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2088.outbound.protection.outlook.com [40.107.223.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9229C10E051
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Jul 2023 05:27:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fnOB3NY7gADAp3f4uIs1y+e4S3jwaGG6kMVV9UlWDCaBlDaPRoA+jKJvKRiFgkVAweL4bQB7LWfP3tN16U1kTy+15cs+/0A3mVMDnnyGuRmJz0v+CH/e4E0OQsktbJmYj2nxDxPNDH8UPLvP9cGTX3QbIen4JUQY/3qSckTGbRRVd/JycLTGdLys9TPsfmvVmOoUzjkgB41jJ/MCv4gdNFT2NbYWlUzGfV2ulrFo4NsuFlSOtGHhqgFkruBtb54CCNm1OnO0hCfHzSxeElW1olJjMx+k8Gi8zU/wScHSUZCpusxzdXZix3eZlSX4M5r8X23YFSamYu4Xu9lx5l8tRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Esj9W+/lCXH8KQ4g3pIXJ5axeiQ3S64ZzhBF7WKZQc0=;
 b=h0/u6CQFDdYQ+hPGds5I1uxUEa8eUhE1mj0sWYNoC7X5z1zdr6Pfp2Dbkz9RL1LjRu9yqH1WQ58UM/whLIOpL3kdDtnmrI1NYjoYAW6MjmQDbetW4npk6JvWkiPj6sIONP/onNiIhyyvFl1HtTrJkTy0wdNXcZPKBZbt14F3NmXwZTq0YYu5EgqOI8OW33u0sGghlKeYGqI3wr9IRv2rs24RLJN3RPVQRhK7OFhxKoW1GD9iKK6qzFa+mo1StQThDmN2fBY4Rw9a44+uXhXwLV3ZX0VyNaSg7KnT6OWsaFHfFWgZVw8Yc0p9dKOw5fLp1MzBRrBASF0nOWWHnP8eBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Esj9W+/lCXH8KQ4g3pIXJ5axeiQ3S64ZzhBF7WKZQc0=;
 b=THcwKC/zvzejPIWJUHSHLeWqFyizrDhC4kQvJ/+stt2y3FLdU/wMg4AW0TqQIlKY3lkA6kfqR99RFw6VrNexS7U5I2mPmkuBEKmXiRFxqxaClzR6bB9o/F3bu6LHE8fLg8teVSVrzBX2u7SZ77midFRkEoKUuneL1iz07uQX33I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by BL1PR12MB5240.namprd12.prod.outlook.com (2603:10b6:208:319::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Fri, 28 Jul
 2023 05:27:02 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::bd4b:829f:c0b1:bad6]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::bd4b:829f:c0b1:bad6%4]) with mapi id 15.20.6631.026; Fri, 28 Jul 2023
 05:27:01 +0000
Message-ID: <32ecb62c-9328-0a09-23d5-ff47eb43b932@amd.com>
Date: Fri, 28 Jul 2023 10:56:49 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH 4/8] amdgpu/pm: Optimize emit_clock_levels for arcturus -
 part 3
Content-Language: en-US
To: Darren Powell <darren.powell@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230427062718.1172269-1-darren.powell@amd.com>
 <20230427062718.1172269-5-darren.powell@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20230427062718.1172269-5-darren.powell@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN0PR01CA0010.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:4f::15) To BYAPR12MB4614.namprd12.prod.outlook.com
 (2603:10b6:a03:a6::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4614:EE_|BL1PR12MB5240:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e1ef09a-f901-414c-79e8-08db8f2b4562
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FEHoPFwDcnf7gzzVc9TxsgZks+yDxcIRdj00K1HohVRrhSueUHuCGwnRh5V3AOOXXCM8hgcPdKXhS3KK2mIXiPxZtoU9JXGH32/imaZVQkEDGzvMARYJK23p/C5gSbGQAxeFu0pFsf8/7X0G9tfxg1lL3lWzyrNyPLW+XhPRWeaRpM8IEDTiZ6+R1ttoa6Y5C3BjJlxEX2HoEYsMeFdQTv+AC8h3sX8YimpMEaTpo1ICboNJ6sAi8w7265BjcaLpNot4gnjcCTKKEQV+iJpeqrz5TqDQ/vN0Jxs13Vmu+fzKrNhHGUfN//uJdN71Z8YxWj3X4nYZNim/ga1HX+l51YMjXEVX0XAxu10w/GmEeLM8nXtAYftQgYnq68Amb7dAHxJvCUr/os5Vs29dzdizNjX7yzjaCblvhSrIYVKMSfoezrtalHJ7SoMvkRoa0RAcnCAmNPE7ak6yVlteEySn2feznnnbQzSzdqNw4Y56AHkqNRO3KsVuYEUnHvYVeOKvd+/x7AL+fK/u3vRaOiTUeCW+NQRToWzRHlNP1TrDVOXgg09Croyj8J8PkG/1qQxOq6eaHIUDMmNnppios1z04WV+qlQbTy83Zv0LqmtWGX1rPvMNubkTwKyJLpxvCgddt+2yhP4Ei+5vTGzeBbe9oQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(376002)(396003)(346002)(136003)(366004)(451199021)(5660300002)(478600001)(31696002)(66946007)(38100700002)(316002)(6506007)(4326008)(66556008)(66476007)(26005)(6666004)(53546011)(186003)(6486002)(6512007)(8936002)(8676002)(2906002)(41300700001)(2616005)(36756003)(86362001)(83380400001)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YUN4aSt5K0hCZ09lQnZ2Ty83bWZjZFlTWTg5OTMvMVYyVnYzaTRkclRZUzFl?=
 =?utf-8?B?R2g4VE5TMWxaQnU1NDlxdmJybEtvN0hEaENFU3d5Y0xzSDNMeXJOK1VBYUFv?=
 =?utf-8?B?T2V0cUhFM1VZOTdxQTQ5L1JmTjlqcWMvdFAwWjJPUDgra0IrdkFENHdZaGNq?=
 =?utf-8?B?bGVvT0RPaHp3SFdlTVRON2NvWk52NjdleHhwdnFMa0NWOHZncUJ0U3BvbnNk?=
 =?utf-8?B?cmFFeFJjTUYzdGZuaHpndzlLRElBSERFS0NUVEFHa0JERG9FTG5YS0pweWdr?=
 =?utf-8?B?NW5ySHYrWit6WGJFelM0emNFOVM0WERwT2J4aFNrUjJGRFZvNW9rVWxmTTdQ?=
 =?utf-8?B?b3RXZnlabjlQMHU4dHorVjB0bzl1SVV3aHBvTEh1K2c4UmdsdEhzVG53KzFa?=
 =?utf-8?B?YjNUM1V3MEcxNlBuaDNvUjI2cGh0ZWlXYTJxTEozVHZwSXhxK21sdTB4cjVO?=
 =?utf-8?B?c2tWa1YzUkRKK2pXR1FpK1gzWkQ4Y0JkL3pUcC9xcHR3ZTk2QXhPMVlBL0xy?=
 =?utf-8?B?dzVQL3ljYy9CU0c3MnJLYk11SVByRUR0c1BrazV6OFUzSit5SmwwRkM0MFJJ?=
 =?utf-8?B?Z0dkTGxhWXpLc2t3dzEvcGdETURTR2tYSXJVbFVkNnRjRVRpdEhRZkx0cW5Q?=
 =?utf-8?B?R2JTTXpESnFtQUtBZXplSmFLSlUxMjJsV01aWHBnaUd1NjRVaHNXRnBxZTdR?=
 =?utf-8?B?TlFXK01SZTVEWlJ2bDdZdFNITlJGREkrNUdGRXhNYTF5WVBPMWxiRkRWbVJJ?=
 =?utf-8?B?dk94VnRaRU5KVEt5OUxBd1NrN2dKSER2RmJrajZhMXNqRS9CZFZhUThpK25u?=
 =?utf-8?B?cFVQQWV4OXZhc3EwTVJRVHhLM1cvZUQvUkJSL2MvU0wrbEpsM0dITVlVQmMw?=
 =?utf-8?B?TUFjQnMwZDg2OW5WOEV5dFdURTY1Qm5CSmFxb0M4dmpZVFhoRDR1NGFhdmFO?=
 =?utf-8?B?aEx4aFAwS0ZBZXJWTUp1S0VEVDA5L3J1Q0FEMGRLR2JiWDZ6NUEyeUFkOWdq?=
 =?utf-8?B?dGI3bGxnWmdWeTFvc0JjUFU2V3g5Z1hIVm0rVG1GOGIrd3NLdVM2VlBlWGhu?=
 =?utf-8?B?QlVNTll0WSt1SXhvT0JDVDV3TnpaRitHb0pMTDFzZjFub0dIZnYrZUFlQXZz?=
 =?utf-8?B?ekNzME1VclkzRjM2RmNsOXZVYVdhaWpKcjBUKzdHZk5hYWxrKzRCNDRXMS9Y?=
 =?utf-8?B?ZHFFRi9BK0NYeWUvWEE2bWhpMXFEQTU1aldLRHQ5WFl3R0Q3bzFNa0N5NVRs?=
 =?utf-8?B?ZjJzUU96enVNZzFYVXZMRngvazJwRmZvY25YWGRpaHZIMDdPa1JJemY5Skt2?=
 =?utf-8?B?SHJzNndtdGNrbTVEZzVmYmFVck44b3ZWeno3ZXFaY3pCUE1VdnpBc1Y4TDZk?=
 =?utf-8?B?T2VhU2V3S0plRFZZLzBYNVBadW54aitjNm4wZUEzZWlVOWZlbFgrU1M3NTUr?=
 =?utf-8?B?Q2w4VC8ySkVjK2hBN3I0QS9PM3FGZFNKV2dObWM0NHc2c09oVy9ERiszVFp3?=
 =?utf-8?B?VS9lNTc4S1RWTDUvOG9xUTd0WnFjU0lNK0U4VjNSZWIwcnU1bzlkRFNwbnhh?=
 =?utf-8?B?SDFTWEhuYVE3ZmRkZHRLT2tCTnErK05TLzY3RTBDR2M3am9icHBua1VvQ3g0?=
 =?utf-8?B?ajBNc21IV05DTHBTMEJub0R1OUp0VlBwN3Joa3pBMTgwOEhNQ3lxV1ZuSVdQ?=
 =?utf-8?B?alh0bG1oNm8rRHJDcFRjRmxoOFZobVppQW92WEtPbFZlbEZaK29PcWYyaXdl?=
 =?utf-8?B?V3NlaGFOVnhuMVpzVXlJdGVZaXBMSzl0RnFydCtMZ3hUSVo5SjJ5K00yL1Zz?=
 =?utf-8?B?clFPMVB6Vm1VWHh4RjJFR1U2MjlvZVNUVE1YNEpCdG9vbVdLQm0wOU5yTzFl?=
 =?utf-8?B?Y2VoN0VheU1QQ1hHcnorOERkVEZtRFZvaWJzMnZtaHVmWEZVTkM3K0I5NFFj?=
 =?utf-8?B?K0syOUFDdWxUSzBXVk9kOGE3QStRbFVjU0pyYllYK014MzBrR3BoN2x6SFdl?=
 =?utf-8?B?MU5xSnI3MTJoL2g4TlZ5Q0RITERqM0tod1JEZXRoS0lPRlpYZThqU2J2Y0Jy?=
 =?utf-8?B?dW4vckhXQzRvazZRQ21BRVJqZG9paDJKV01vM0xnMHBRUEpNLys4VHFnVHE1?=
 =?utf-8?Q?jMSbkfv+IT2o0aVKD/iTBOs/s?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e1ef09a-f901-414c-79e8-08db8f2b4562
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2023 05:27:01.7307 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e5EHMfFnV0Xv2M+nJ+gebGeNzKHqhzZKTTS38KM0Au1koYiinEdRumVts6esxwPS
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
>     split switch statement into two and consolidate the common
>       code for printing most of the types of clock speeds
> 
> Signed-off-by: Darren Powell <darren.powell@amd.com>
> ---
>   .../gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c | 77 ++++++-------------
>   1 file changed, 24 insertions(+), 53 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
> index aea78f9dbae2..0e26c8b31daa 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
> @@ -787,19 +787,6 @@ static int arcturus_emit_clk_levels(struct smu_context *smu,
>   		single_dpm_table = &(dpm_context->dpm_tables.gfx_table);
>   		arcturus_get_clk_table(smu, &clocks, single_dpm_table);
>   
> -		/*
> -		 * For DPM disabled case, there will be only one clock level.
> -		 * And it's safe to assume that is always the current clock.
> -		 */
> -		for (i = 0; i < clocks.num_levels; i++) {
> -			clock_mhz = clocks.data[i].clocks_in_khz / 1000;
> -			freq_match = arcturus_freqs_in_same_level(clock_mhz, cur_value);
> -			freq_match |= (clocks.num_levels == 1);
> -
> -			*offset += sysfs_emit_at(buf, *offset, "%d: %uMhz %s\n",
> -						 i, clock_mhz,
> -						 freq_match ? "*" : "");
> -		}
>   		break;
>   
>   	case SMU_MCLK:
> @@ -812,15 +799,6 @@ static int arcturus_emit_clk_levels(struct smu_context *smu,
>   		single_dpm_table = &(dpm_context->dpm_tables.uclk_table);
>   		arcturus_get_clk_table(smu, &clocks, single_dpm_table);
>   
> -		for (i = 0; i < clocks.num_levels; i++) {
> -			clock_mhz = clocks.data[i].clocks_in_khz / 1000;
> -			freq_match = arcturus_freqs_in_same_level(clock_mhz, cur_value);
> -			freq_match |= (clocks.num_levels == 1);
> -
> -			*offset += sysfs_emit_at(buf, *offset, "%d: %uMhz %s\n",
> -						 i, clock_mhz,
> -						 freq_match ? "*" : "");
> -		}
>   		break;
>   
>   	case SMU_SOCCLK:
> @@ -833,15 +811,6 @@ static int arcturus_emit_clk_levels(struct smu_context *smu,
>   		single_dpm_table = &(dpm_context->dpm_tables.soc_table);
>   		arcturus_get_clk_table(smu, &clocks, single_dpm_table);
>   
> -		for (i = 0; i < clocks.num_levels; i++) {
> -			clock_mhz = clocks.data[i].clocks_in_khz / 1000;
> -			freq_match = arcturus_freqs_in_same_level(clock_mhz, cur_value);
> -			freq_match |= (clocks.num_levels == 1);
> -
> -			*offset += sysfs_emit_at(buf, *offset, "%d: %uMhz %s\n",
> -						 i, clock_mhz,
> -						 freq_match ? "*" : "");
> -		}
>   		break;
>   
>   	case SMU_FCLK:
> @@ -854,15 +823,6 @@ static int arcturus_emit_clk_levels(struct smu_context *smu,
>   		single_dpm_table = &(dpm_context->dpm_tables.fclk_table);
>   		arcturus_get_clk_table(smu, &clocks, single_dpm_table);
>   
> -		for (i = 0; i < clocks.num_levels; i++) {
> -			clock_mhz = clocks.data[i].clocks_in_khz / 1000;
> -			freq_match = arcturus_freqs_in_same_level(clock_mhz, cur_value);
> -			freq_match |= (clocks.num_levels == 1);
> -
> -			*offset += sysfs_emit_at(buf, *offset, "%d: %uMhz %s\n",
> -						 i, clock_mhz,
> -						 freq_match ? "*" : "");
> -		}
>   		break;
>   
>   	case SMU_VCLK:
> @@ -875,15 +835,6 @@ static int arcturus_emit_clk_levels(struct smu_context *smu,
>   		single_dpm_table = &(dpm_context->dpm_tables.vclk_table);
>   		arcturus_get_clk_table(smu, &clocks, single_dpm_table);
>   
> -		for (i = 0; i < clocks.num_levels; i++) {
> -			clock_mhz = clocks.data[i].clocks_in_khz / 1000;
> -			freq_match = arcturus_freqs_in_same_level(clock_mhz, cur_value);
> -			freq_match |= (clocks.num_levels == 1);
> -
> -			*offset += sysfs_emit_at(buf, *offset, "%d: %uMhz %s\n",
> -						 i, clock_mhz,
> -						 freq_match ? "*" : "");
> -		}
>   		break;
>   
>   	case SMU_DCLK:
> @@ -896,20 +847,40 @@ static int arcturus_emit_clk_levels(struct smu_context *smu,
>   		single_dpm_table = &(dpm_context->dpm_tables.dclk_table);
>   		arcturus_get_clk_table(smu, &clocks, single_dpm_table);
>   
> +		break;
> +
> +	case SMU_PCIE:
> +		gen_speed = smu_v11_0_get_current_pcie_link_speed_level(smu);
> +		lane_width = smu_v11_0_get_current_pcie_link_width_level(smu);
> +		break;
> +
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	switch (type) {
> +	case SMU_SCLK:
> +	case SMU_MCLK:
> +	case SMU_SOCCLK:
> +	case SMU_FCLK:
> +	case SMU_VCLK:
> +	case SMU_DCLK:
> +		/*
> +		 * For DPM disabled case, there will be only one clock level.
> +		 * And it's safe to assume that is always the current clock.
> +		 */
>   		for (i = 0; i < clocks.num_levels; i++) {
>   			clock_mhz = clocks.data[i].clocks_in_khz / 1000;
>   			freq_match = arcturus_freqs_in_same_level(clock_mhz, cur_value);
>   			freq_match |= (clocks.num_levels == 1);
>   
>   			*offset += sysfs_emit_at(buf, *offset, "%d: %uMhz %s\n",
> -						 i, clock_mhz,
> -						 freq_match ? "*" : "");
> +				i, clock_mhz,
> +				freq_match ? "*" : "");
>   		}

<Nit> Making this a small inline function or a goto may be considered 
instead of another switch statement.

Thanks,
Lijo
>   		break;
>   
>   	case SMU_PCIE:
> -		gen_speed = smu_v11_0_get_current_pcie_link_speed_level(smu);
> -		lane_width = smu_v11_0_get_current_pcie_link_width_level(smu);
>   		*offset += sysfs_emit_at(buf, *offset, "0: %s %s %dMhz *\n",
>   				(gen_speed == 0) ? "2.5GT/s," :
>   				(gen_speed == 1) ? "5.0GT/s," :
