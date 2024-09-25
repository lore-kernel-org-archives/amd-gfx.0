Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2639CF58E5
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Sep 2024 13:35:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5AE3710E830;
	Wed, 25 Sep 2024 13:35:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hOREoKYg";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2052.outbound.protection.outlook.com [40.107.96.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4B12310E830
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Sep 2024 13:35:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O5QWgtarGytyEW89RZL5kn75BtBkQMrElpPbpu7VBDixP4e6fh2J9vO8p5X8iAqQtb4cq1r9fvGhrUrNQBjPCX4Gya1Hild0ylNBdx0dJYtGek9RHA0DeibYZ9JpM+W4uJ373REBjplxZKTiP/2C+vadE5rDr29cqjW2So4ZT/BWHtoGGQ8yItanPutt6QKDT70Y8x5R0YlWm0S+hnINFyHeYR72xg3LEfQnhs7QChhBbqYAE4nchGBWLvG5AZaPXDwNSPmazX+ikU4h1h8xwO62b5fcV4+uX9aknS0HTc2rit2gdP2IqxmTlGy1JuEcl/uf+z1rFZEWdwGEB2gCQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ict92CDgTltKi9Y1U2a5PAHG2QtrxkwjCGVj+sfvhCA=;
 b=h9Pgc9QfIR0Vc1NOudJuZdvNo6RlbeUc1su3FAojFBjyFDggqw48puYOM9bPBRphe32Q0SvopUZTiguoSzZMBYvbmarza8puboawOndCbDOD/fnEGNv6Sz7X2fsA5Eyx02yCrlKIA1APKtOV/nXqixiFJbZRtkjnz66OHLsh9tpNTCjbpmHQ5wbPji0n5WEad5xJqQpQnJjlbF4GMS7zs0ZNmF/llQs9IGxsl1FyZprlDXiZfmfxz/KCSIDKUfzid6vkLcHpvUdyxFMf1UXfkx2raLIeSFlEHaBaY/mfdO4HBG9EszzNsw05lejvkck3xOmPcwQZwRqINUEH52ELoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ict92CDgTltKi9Y1U2a5PAHG2QtrxkwjCGVj+sfvhCA=;
 b=hOREoKYgp0JbFWVHH1BJi6xBqdLoDl+jWftivszwVOem/d2bDVtii8ZYw/FJiwF69yPQ12FxOQ2SXgAuXnTJvI3l30zMGIdDBG0k/Q/uXyfqeZ49Q158foQXMdzkB3poDnyvpDOw9bxfaDpgdQZh24fooEaDtFuxNHLBcmTYTyU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 DS7PR12MB6045.namprd12.prod.outlook.com (2603:10b6:8:86::18) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7982.27; Wed, 25 Sep 2024 13:35:33 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%5]) with mapi id 15.20.7982.022; Wed, 25 Sep 2024
 13:35:33 +0000
Message-ID: <74f68af1-ed33-422c-b6f0-d1a036a550b1@amd.com>
Date: Wed, 25 Sep 2024 19:05:25 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 5/9] drm/amd/pm: use pm_runtime_get_if_active for
 debugfs getters
To: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com,
 kenneth.feng@amd.com, mario.limonciello@amd.com
References: <20240925075607.23929-1-pierre-eric.pelloux-prayer@amd.com>
 <20240925075607.23929-6-pierre-eric.pelloux-prayer@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20240925075607.23929-6-pierre-eric.pelloux-prayer@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0155.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:26::10) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|DS7PR12MB6045:EE_
X-MS-Office365-Filtering-Correlation-Id: dee548c2-5b2c-42e2-e919-08dcdd66edeb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?K3ZLUUdGZ1kxL2orSzdIN1FnY3FBWmhiNEg2RDE3QVdKTVM5cWUxTExqSEl6?=
 =?utf-8?B?QlFRNnBYZVFlUTNuQzkrNlQ0aVEvajJXcFgyYkZMVWF2MHRRa3Z5SEt1RHBI?=
 =?utf-8?B?enlReGpKc3lNcExjRThlaS9nSFgrbWlGTWRQMldMYTcxeTBNRm8rNlB0bFdM?=
 =?utf-8?B?aytVaVQzZzVkUC94UFdOeDd4NE9lRzM3RTNjTXBGZzhYbEtXUnQ3S3NBWDFz?=
 =?utf-8?B?V3hzeURQZllrMjhwaDlZcUtFMWthWUlmZFZQS2pBOS9YM01KcjYrTW5jd3py?=
 =?utf-8?B?WmZYeU1nYmFtU2tpWWM5ZEx6NVNFSWQ3RlpLdzBzTGVxbi9JbnRoc2Z4MWcr?=
 =?utf-8?B?WDQxbGNWaVNKVzN0NWFuR0xaQU9XNit4ZFNaY3pXQWVaUUZ0SWpQUzJJQ1Nv?=
 =?utf-8?B?amxHdzM2RDd6ZUlubUpNcFVCMWxONVdYK1VWNGhlU3FEUHRtOHBtMjlBeXVu?=
 =?utf-8?B?NHBXR2VKNEtSNmhGeFlNcXAwRDhnZ3ZUc3dRbFo3VndXa3ZhbGdkdGtkaGhr?=
 =?utf-8?B?QXFtQTVzbDJrSVUvQjNLZ0tDeEI5L1FWR2VCdTJQZWlKSlkvZ1NISXB4NGww?=
 =?utf-8?B?MW9Iam9TSy9hQTc3RUFuU1hxZ2QxOGgvUDhGUTV4b1U4aW1tT2h1amhITUZw?=
 =?utf-8?B?OGdiWXRYc3VwTWFOcTFQRi95UlBNbzBQOE5HZjZKTGR4Z0k4L3ZtbFZpNlpl?=
 =?utf-8?B?YWN2U2xvMUlFTkFkSmVPQ2ZxSkJvdGxKTkRtQUJJbWZjK1BTYzBkblZjVEc3?=
 =?utf-8?B?YnBieHlCQjZQTEc1N2FENU1pdExVS3RNR3U2NlZQWHd3R2sxSGhvTkFHQlBN?=
 =?utf-8?B?M2RhTVRxRi9MWkpaRld6Vk9CYzY4RmRJNy91eUx6TWNFRmhLOHVtbU9LdGxt?=
 =?utf-8?B?ZVJlT29LSi81R1ZFZ1VCaUhtaStJK0YzZVhSZ2dWY0U3Y1VPRFNJUEcrODhG?=
 =?utf-8?B?dlNKQlF5MGJmem00bHkvY3FKR0JqUmdMOG5BUzZiMW1NNXFNVFAvMzdCQ0Z2?=
 =?utf-8?B?c0Z1RlZQY25RSzdWMC9ZUjVVakVoajcyQTBCWGdmb3J5VUlXcThhNnJ3bGZ4?=
 =?utf-8?B?U3FvYSs2cDI3SkdSVGFtdHBUV1NFem9UdC95ckVKdHlJbnRDZXVEdElTYm5R?=
 =?utf-8?B?NHVReHdMQUZNUmR2MEs3YTZTNTMrZnJxZFZyMy92SWo5am9HM2N5Vk5NeXpj?=
 =?utf-8?B?RmVtbVMwMWZJd0FYTko5QlJiWkl6dk5yV3B2QllwdXFFVnNHcnJWd05TNGox?=
 =?utf-8?B?T2VIS1lrOGljN0ViaXVTbGRRd2YyTG5jL2lXVHkwR2Q1d3ZiRU5FVmNpZnls?=
 =?utf-8?B?Vm14OEE4cG84UzhweDVJcDNmTHdSaEZnUlMxTTVVbEJoZlFnUzQ1SGIrNVlv?=
 =?utf-8?B?YlA1cm1zdGNGSUtYbUp6K3kreHk0NUw2WnU1RmI5YTROZGJaTFBjZEY0VkY5?=
 =?utf-8?B?UVI1ZnRzVUhXNkZBUk5UWENRbzB5NVdISHp1a0tMRkRNNXVyZHFXeTFIMGh6?=
 =?utf-8?B?QWUyZjl0aDkvdjBhNWRVUTNaSkx3M0loQ2h3b3o4TW0yVW9UeWM2eWJZM1VF?=
 =?utf-8?B?d1lwVHlZMmJpMHN5TFkzN0lUYitLYmlobXJZWkZkVWQ1dGlMYncvZm0xcUVu?=
 =?utf-8?B?Zi9UbGxmVjh5SWtERTlsS3k1MEM2SUx1VzZ2WEVPNXNrY1FYTHkyRnM4Y05N?=
 =?utf-8?B?empydER2RThKU3plTU43WTZuMzhpTERhek9uWTRmbzRLTnl4MmZDeHdPRjdv?=
 =?utf-8?B?aTRwM2dxNC9uQ2FoQ0pIQUxEV0JucGp2Z0g0Z0Z4SnhLUzIwQmMzblN2aUtr?=
 =?utf-8?B?VlNUZlluMS9vOUExQ01SQT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V2FSYWRLem5aWENwbDBpUjFDOXpJaDVtQVV2ZWlPNUs5YmtqSmRCV1Z3eVZp?=
 =?utf-8?B?dVhrcnY1NEMzeUEvTmVOQzNwMHp5TWUwbTFIV1lWa1Z1c3Y2c2VycDROeUNx?=
 =?utf-8?B?L0VxUUJDN2FVUkhyekswL1pTZVlsZWhoZzhkV3p2a0Zkc0M2UlBnekJhOXJ5?=
 =?utf-8?B?RUlhTko3cGhoMjF3YU5qbkplQUVXMGc0U25WL3grVitkc29sMThuNXA1ekQr?=
 =?utf-8?B?T0xhdkE0TmRqWkwvTVU2RndJNE9SekJEN1hOdlNkeGNMK3RFVlJNcGtJOWpT?=
 =?utf-8?B?UXdRRE1vZnBraFArTTlwTXJSakl4ZHcyanhlNy9NUXErcGxGekZiaEoyM0Nz?=
 =?utf-8?B?S1BrOVVnNVBGZ1NTcmNCUEF4bkRNYlluU1MxSDM5UGw1MFVMb1B5TDdRZWVF?=
 =?utf-8?B?SldEbEQzUCs5M1hUdU8wMlRwTWhyYjE4bUxyWUNPdkV1QnZVbnltdEE3RXNq?=
 =?utf-8?B?M3hVMmROWWFRQXFaaFJDM1NXbVcrbDNkck5XWEpRWXJ5WDNWaFYzOFBMblBW?=
 =?utf-8?B?cFNjeXI0TS9yRTZDbkdFNjZzTWtwNDh2WFVaVmlvWmhEZFF2SGhSeWtDb3Ju?=
 =?utf-8?B?azBpUVZMNnZadXFhUHZzVitpemZ0b0VoTEl0bG5pdHlOeFd2STB5KzdPWGlh?=
 =?utf-8?B?UEdmVTlGZThMaW9ITUluSnM1Zlcyc3B5SHlsMUl6T0FFSDhVcHVkKzcvTDJa?=
 =?utf-8?B?MktDY2ErYmFydDBJeTJ0MXRKZmZDSUVjOWdDWnpSRDRFdzcwMjNxa3NUMllK?=
 =?utf-8?B?WDhQUmZHbXVJSXVFUmFrSkJFTXJGYTM5c05oS1g3eS8va0J2cG15L2F0UFIw?=
 =?utf-8?B?L1FONlpnMkc2bTZ2cDFKN3NSYkd4N2o0ekhPZWE3Q1NrdkpsT0dzR2Vtazdu?=
 =?utf-8?B?a0hKSkVtb1BVaEkvcVg3WXdBMEx2Zmp3T1ZSV1N6Wm5VNS9UalpteTg4NjVp?=
 =?utf-8?B?QUhsbjMrWEh4UVg4R0wzdm9wZXVLTHhWdHZPN0c4clZZYmJYT0ZpS01wUVlH?=
 =?utf-8?B?c1lzOHNkei9qMjBiTExabVJGU0tsY2F4WDlyb1FUSHhOMGd5SERHeXJsQ3NX?=
 =?utf-8?B?TEMvNWYraVBYdFkxTmFqQll5V3ZlcFdIbW4rS0pReEw2bVBxRHE3WTFtOEFP?=
 =?utf-8?B?d3oyS0I3QjlDc3o3TGtGSUExM2wrdXJGNmk2LzJEVStZOWQ1MjB0ak4zcWpR?=
 =?utf-8?B?eXFyS2RxcXRpakdha1FNNVorWHYrYUhNYytyL2JDRUZiL2ZHOUtOWGY3N3RG?=
 =?utf-8?B?MTlZbVYzdmp1U0F4VmZzZkp0MDV6dWhkQXFldXdlVE8zRVBZNFhxQzB6eGRq?=
 =?utf-8?B?WGg1TXIzOWF4TmVNc1pVVzd1YktQZURhVTJ5T2VhWVd0SElkWWNSeXlvLzdI?=
 =?utf-8?B?UnFIbTFyWEtUVGVQVVRvNWZIelRLTjNyMDNjekx3a0E3Z1AwUnhFNkllNG1M?=
 =?utf-8?B?N3duRjlza0dla2plQmNxbGpjR1pxQnEwM0tOUFErdXpaZzBoVU9jMkhMSGE5?=
 =?utf-8?B?SWJqUG5pSlVQVm1BSkZhTC9oMzdaYUdJSk9ibjE3YitKenJ0YXNoclhpcGZO?=
 =?utf-8?B?YXg0V3cxbllGZUhLSENhREhaclIyWWdZODlmTDRuWDZmaXhyN2dpMDVyZElZ?=
 =?utf-8?B?V1RZN2twb2NKOHdVT0lVS2RQcGhlL2hOa2FUcy9id3NpbHBKRTVhMVZHMHpB?=
 =?utf-8?B?dEZQU2YxV2dxb3lad2NMUGk4MVBzaEdEcjF0Zlh4MHhXakljc2tkRzljN1pI?=
 =?utf-8?B?SnlFczRyYmRZVTlQNFRmbDFQZFlhazk4SW9wYVlUR25vTExDUVhkUUtUUFNq?=
 =?utf-8?B?dFJiMzU5VXlqSnZBMFlZbkErTlRyTnB5T2RHTW9uNldmSXJndHlTZlZoTUE1?=
 =?utf-8?B?aUsyMWpQVEtMcFdVdmVCL0FYRjh3UWt3b3JUaFdsRjdicGNWR1RNQmZSMlRy?=
 =?utf-8?B?engrZThzdnRkSjhzRGpTR1cvSHlXbU1kbkZZMENhaHVIRUgveHZESVRQWEpN?=
 =?utf-8?B?N0I3cjlIMENPbW9HRDV3UDZtRlBuMG8vajdzRE1mQ04ySlAvNVNsQ1FwY3p5?=
 =?utf-8?B?K1gzcG9MRzZxNFBEL1kwNlBqV001NEV5KzFldUp2MXIxaCsxSXlqU3BINEty?=
 =?utf-8?Q?ZjHi77E8Qy77hgfpl0kdgSjZ0?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dee548c2-5b2c-42e2-e919-08dcdd66edeb
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2024 13:35:33.1583 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uQWLfGC+ZrZJ/3KIT3PkpeoMYHyenkYinqesPh2c6an59e5RkmGhmx+b+S5bRcJj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6045
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



On 9/25/2024 1:24 PM, Pierre-Eric Pelloux-Prayer wrote:
> Don't wake up the GPU for reading pm values. Instead, take a runtime
> powermanagement ref when trying to read it iff the GPU is already
> awake.
> 
> This avoids spurious wake ups (eg: from applets).
> 
> We use pm_runtime_get_if_in_active(ign_usage_count=true) because we care
> about "is the GPU awake?" not about "is the GPU awake and something else
> prevents suspend?".
> 
> Tested-by: Mario Limonciello <mario.limonciello@amd.com>
> Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
> ---
>  drivers/gpu/drm/amd/pm/amdgpu_pm.c | 138 ++++++++++++++---------------
>  1 file changed, 69 insertions(+), 69 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> index c8f34b1a4d8e..f1f339b75380 100644
> --- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> +++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> @@ -145,9 +145,9 @@ static ssize_t amdgpu_get_power_dpm_state(struct device *dev,
>  	if (adev->in_suspend && !adev->in_runpm)
>  		return -EPERM;
>  
> -	ret = pm_runtime_resume_and_get(ddev->dev);
> -	if (ret < 0)
> -		return ret;
> +	ret = pm_runtime_get_if_active(ddev->dev, true);
> +	if (ret <= 0)
> +		return ret ?: -EPERM;

Not all our devices support runtime PM.

As per the API documentation -

"-EINVAL is returned if runtime PM is disabled for the
device, in which case also the usage_count will remain unmodified."

If that's true, this won't be working on devices without runtime PM support.

Thanks,
Lijo
>  
>  	amdgpu_dpm_get_current_power_state(adev, &pm);
>  
> @@ -268,9 +268,9 @@ static ssize_t amdgpu_get_power_dpm_force_performance_level(struct device *dev,
>  	if (adev->in_suspend && !adev->in_runpm)
>  		return -EPERM;
>  
> -	ret = pm_runtime_resume_and_get(ddev->dev);
> -	if (ret < 0)
> -		return ret;
> +	ret = pm_runtime_get_if_active(ddev->dev, true);
> +	if (ret <= 0)
> +		return ret ?: -EPERM;
>  
>  	level = amdgpu_dpm_get_performance_level(adev);
>  
> @@ -364,9 +364,9 @@ static ssize_t amdgpu_get_pp_num_states(struct device *dev,
>  	if (adev->in_suspend && !adev->in_runpm)
>  		return -EPERM;
>  
> -	ret = pm_runtime_resume_and_get(ddev->dev);
> -	if (ret < 0)
> -		return ret;
> +	ret = pm_runtime_get_if_active(ddev->dev, true);
> +	if (ret <= 0)
> +		return ret ?: -EPERM;
>  
>  	if (amdgpu_dpm_get_pp_num_states(adev, &data))
>  		memset(&data, 0, sizeof(data));
> @@ -399,9 +399,9 @@ static ssize_t amdgpu_get_pp_cur_state(struct device *dev,
>  	if (adev->in_suspend && !adev->in_runpm)
>  		return -EPERM;
>  
> -	ret = pm_runtime_resume_and_get(ddev->dev);
> -	if (ret < 0)
> -		return ret;
> +	ret = pm_runtime_get_if_active(ddev->dev, true);
> +	if (ret <= 0)
> +		return ret ?: -EPERM;
>  
>  	amdgpu_dpm_get_current_power_state(adev, &pm);
>  
> @@ -526,9 +526,9 @@ static ssize_t amdgpu_get_pp_table(struct device *dev,
>  	if (adev->in_suspend && !adev->in_runpm)
>  		return -EPERM;
>  
> -	ret = pm_runtime_resume_and_get(ddev->dev);
> -	if (ret < 0)
> -		return ret;
> +	ret = pm_runtime_get_if_active(ddev->dev, true);
> +	if (ret <= 0)
> +		return ret ?: -EPERM;
>  
>  	size = amdgpu_dpm_get_pp_table(adev, &table);
>  
> @@ -840,9 +840,9 @@ static ssize_t amdgpu_get_pp_od_clk_voltage(struct device *dev,
>  	if (adev->in_suspend && !adev->in_runpm)
>  		return -EPERM;
>  
> -	ret = pm_runtime_resume_and_get(ddev->dev);
> -	if (ret < 0)
> -		return ret;
> +	ret = pm_runtime_get_if_active(ddev->dev, true);
> +	if (ret <= 0)
> +		return ret ?: -EPERM;
>  
>  	for (clk_index = 0 ; clk_index < 6 ; clk_index++) {
>  		ret = amdgpu_dpm_emit_clock_levels(adev, od_clocks[clk_index], buf, &size);
> @@ -930,9 +930,9 @@ static ssize_t amdgpu_get_pp_features(struct device *dev,
>  	if (adev->in_suspend && !adev->in_runpm)
>  		return -EPERM;
>  
> -	ret = pm_runtime_resume_and_get(ddev->dev);
> -	if (ret < 0)
> -		return ret;
> +	ret = pm_runtime_get_if_active(ddev->dev, true);
> +	if (ret <= 0)
> +		return ret ?: -EPERM;
>  
>  	size = amdgpu_dpm_get_ppfeature_status(adev, buf);
>  	if (size <= 0)
> @@ -996,9 +996,9 @@ static ssize_t amdgpu_get_pp_dpm_clock(struct device *dev,
>  	if (adev->in_suspend && !adev->in_runpm)
>  		return -EPERM;
>  
> -	ret = pm_runtime_resume_and_get(ddev->dev);
> -	if (ret < 0)
> -		return ret;
> +	ret = pm_runtime_get_if_active(ddev->dev, true);
> +	if (ret <= 0)
> +		return ret ?: -EPERM;
>  
>  	ret = amdgpu_dpm_emit_clock_levels(adev, type, buf, &size);
>  	if (ret == -ENOENT)
> @@ -1245,9 +1245,9 @@ static ssize_t amdgpu_get_pp_sclk_od(struct device *dev,
>  	if (adev->in_suspend && !adev->in_runpm)
>  		return -EPERM;
>  
> -	ret = pm_runtime_resume_and_get(ddev->dev);
> -	if (ret < 0)
> -		return ret;
> +	ret = pm_runtime_get_if_active(ddev->dev, true);
> +	if (ret <= 0)
> +		return ret ?: -EPERM;
>  
>  	value = amdgpu_dpm_get_sclk_od(adev);
>  
> @@ -1302,9 +1302,9 @@ static ssize_t amdgpu_get_pp_mclk_od(struct device *dev,
>  	if (adev->in_suspend && !adev->in_runpm)
>  		return -EPERM;
>  
> -	ret = pm_runtime_resume_and_get(ddev->dev);
> -	if (ret < 0)
> -		return ret;
> +	ret = pm_runtime_get_if_active(ddev->dev, true);
> +	if (ret <= 0)
> +		return ret ?: -EPERM;
>  
>  	value = amdgpu_dpm_get_mclk_od(adev);
>  
> @@ -1379,9 +1379,9 @@ static ssize_t amdgpu_get_pp_power_profile_mode(struct device *dev,
>  	if (adev->in_suspend && !adev->in_runpm)
>  		return -EPERM;
>  
> -	ret = pm_runtime_resume_and_get(ddev->dev);
> -	if (ret < 0)
> -		return ret;
> +	ret = pm_runtime_get_if_active(ddev->dev, true);
> +	if (ret <= 0)
> +		return ret ?: -EPERM;
>  
>  	size = amdgpu_dpm_get_power_profile_mode(adev, buf);
>  	if (size <= 0)
> @@ -1467,9 +1467,9 @@ static int amdgpu_hwmon_get_sensor_generic(struct amdgpu_device *adev,
>  	if (adev->in_suspend && !adev->in_runpm)
>  		return -EPERM;
>  
> -	r = pm_runtime_resume_and_get(adev->dev);
> -	if (r < 0)
> -		return r;
> +	r = pm_runtime_get_if_active(adev->dev, true);
> +	if (r <= 0)
> +		return r ?: -EPERM;
>  
>  	/* get the sensor value */
>  	r = amdgpu_dpm_read_sensor(adev, sensor, query, &size);
> @@ -1583,9 +1583,9 @@ static ssize_t amdgpu_get_pcie_bw(struct device *dev,
>  	if (!adev->asic_funcs->get_pcie_usage)
>  		return -ENODATA;
>  
> -	ret = pm_runtime_resume_and_get(ddev->dev);
> -	if (ret < 0)
> -		return ret;
> +	ret = pm_runtime_get_if_active(ddev->dev, true);
> +	if (ret <= 0)
> +		return ret ?: -EPERM;
>  
>  	amdgpu_asic_get_pcie_usage(adev, &count0, &count1);
>  
> @@ -1711,9 +1711,9 @@ static ssize_t amdgpu_get_apu_thermal_cap(struct device *dev,
>  	struct drm_device *ddev = dev_get_drvdata(dev);
>  	struct amdgpu_device *adev = drm_to_adev(ddev);
>  
> -	ret = pm_runtime_resume_and_get(ddev->dev);
> -	if (ret < 0)
> -		return ret;
> +	ret = pm_runtime_get_if_active(ddev->dev, true);
> +	if (ret <= 0)
> +		return ret ?: -EPERM;
>  
>  	ret = amdgpu_dpm_get_apu_thermal_limit(adev, &limit);
>  	if (!ret)
> @@ -1787,9 +1787,9 @@ static ssize_t amdgpu_get_pm_metrics(struct device *dev,
>  	if (adev->in_suspend && !adev->in_runpm)
>  		return -EPERM;
>  
> -	ret = pm_runtime_resume_and_get(ddev->dev);
> -	if (ret < 0)
> -		return ret;
> +	ret = pm_runtime_get_if_active(ddev->dev, true);
> +	if (ret <= 0)
> +		return ret ?: -EPERM;
>  
>  	size = amdgpu_dpm_get_pm_metrics(adev, buf, PAGE_SIZE);
>  
> @@ -1825,9 +1825,9 @@ static ssize_t amdgpu_get_gpu_metrics(struct device *dev,
>  	if (adev->in_suspend && !adev->in_runpm)
>  		return -EPERM;
>  
> -	ret = pm_runtime_resume_and_get(ddev->dev);
> -	if (ret < 0)
> -		return ret;
> +	ret = pm_runtime_get_if_active(ddev->dev, true);
> +	if (ret <= 0)
> +		return ret ?: -EPERM;
>  
>  	size = amdgpu_dpm_get_gpu_metrics(adev, &gpu_metrics);
>  	if (size <= 0)
> @@ -2700,9 +2700,9 @@ static ssize_t amdgpu_hwmon_get_pwm1_enable(struct device *dev,
>  	if (adev->in_suspend && !adev->in_runpm)
>  		return -EPERM;
>  
> -	ret = pm_runtime_resume_and_get(adev->dev);
> -	if (ret < 0)
> -		return ret;
> +	ret = pm_runtime_get_if_active(adev->dev, true);
> +	if (ret <= 0)
> +		return ret ?: -EPERM;
>  
>  	ret = amdgpu_dpm_get_fan_control_mode(adev, &pwm_mode);
>  
> @@ -2828,9 +2828,9 @@ static ssize_t amdgpu_hwmon_get_pwm1(struct device *dev,
>  	if (adev->in_suspend && !adev->in_runpm)
>  		return -EPERM;
>  
> -	err = pm_runtime_resume_and_get(adev->dev);
> -	if (err < 0)
> -		return err;
> +	err = pm_runtime_get_if_active(adev->dev, true);
> +	if (err <= 0)
> +		return err ?: -EPERM;
>  
>  	err = amdgpu_dpm_get_fan_speed_pwm(adev, &speed);
>  
> @@ -2855,9 +2855,9 @@ static ssize_t amdgpu_hwmon_get_fan1_input(struct device *dev,
>  	if (adev->in_suspend && !adev->in_runpm)
>  		return -EPERM;
>  
> -	err = pm_runtime_resume_and_get(adev->dev);
> -	if (err < 0)
> -		return err;
> +	err = pm_runtime_get_if_active(adev->dev, true);
> +	if (err <= 0)
> +		return err ?: -EPERM;
>  
>  	err = amdgpu_dpm_get_fan_speed_rpm(adev, &speed);
>  
> @@ -2916,9 +2916,9 @@ static ssize_t amdgpu_hwmon_get_fan1_target(struct device *dev,
>  	if (adev->in_suspend && !adev->in_runpm)
>  		return -EPERM;
>  
> -	err = pm_runtime_resume_and_get(adev->dev);
> -	if (err < 0)
> -		return err;
> +	err = pm_runtime_get_if_active(adev->dev, true);
> +	if (err <= 0)
> +		return err ?: -EPERM;
>  
>  	err = amdgpu_dpm_get_fan_speed_rpm(adev, &rpm);
>  
> @@ -2986,9 +2986,9 @@ static ssize_t amdgpu_hwmon_get_fan1_enable(struct device *dev,
>  	if (adev->in_suspend && !adev->in_runpm)
>  		return -EPERM;
>  
> -	ret = pm_runtime_resume_and_get(adev->dev);
> -	if (ret < 0)
> -		return ret;
> +	ret = pm_runtime_get_if_active(adev->dev, true);
> +	if (ret <= 0)
> +		return ret ?: -EPERM;
>  
>  	ret = amdgpu_dpm_get_fan_control_mode(adev, &pwm_mode);
>  
> @@ -3152,9 +3152,9 @@ static ssize_t amdgpu_hwmon_show_power_cap_generic(struct device *dev,
>  	if (adev->in_suspend && !adev->in_runpm)
>  		return -EPERM;
>  
> -	r = pm_runtime_resume_and_get(adev->dev);
> -	if (r < 0)
> -		return r;
> +	r = pm_runtime_get_if_active(adev->dev, true);
> +	if (r <= 0)
> +		return r ?: -EPERM;
>  
>  	r = amdgpu_dpm_get_power_limit(adev, &limit,
>  				      pp_limit_level, power_type);
> @@ -3685,9 +3685,9 @@ static int amdgpu_retrieve_od_settings(struct amdgpu_device *adev,
>  	if (adev->in_suspend && !adev->in_runpm)
>  		return -EPERM;
>  
> -	ret = pm_runtime_resume_and_get(adev->dev);
> -	if (ret < 0)
> -		return ret;
> +	ret = pm_runtime_get_if_active(adev->dev, true);
> +	if (ret <= 0)
> +		return ret ?: -EPERM;
>  
>  	size = amdgpu_dpm_print_clock_levels(adev, od_type, buf);
>  	if (size == 0)
