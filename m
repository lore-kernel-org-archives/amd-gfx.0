Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56A62C433FE
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Oct 2022 16:13:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7297210E008;
	Fri,  7 Oct 2022 16:13:25 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2044.outbound.protection.outlook.com [40.107.212.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DACBC10E008
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Oct 2022 16:13:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GpI+e2J0KcS5cbxjn4sW+HYywYckkSZXYNNc465fA9w9V97d6S/zX46C4wjHd1uGeO3ulSohY5RZk5GRcK3mvmd4LJ0vgy+d0oIMSCMJS7ru4f3WXAV/Jzkwd41yUsNuI/kfCzoZ9M5HiW8Rln0+Ipkt/RjtRxzymH2Wsg1K9FMvCY4q/FQbJKpgBYyqLPdSKdV973SG4L5I2+VPvm+TuYW5xZljLCGtbVOQri+BbRxyw7Brd41dSDtVk3yGSYQGXpUndKS66DgGptN7fszghSXHDMKigbJ1j6LDK79BRF9f4conV8zvoLR2VUUAFOW/t+Ti6wYxrVia2J091t55kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=COfOI+IBPGmcIhYljjbFuYuswyZamDCyG0pcO6m3Cm4=;
 b=LGagafb5SwvJNGUrtsF+9UU8dqHZganj5R0VDtJJhIwKeXwNVHBKMEtOvovqJzRrNNbWoEWEEZweHWVM/K7we8l/nmJK7lpyvvCdGldiBgl5NCVcUnDQUsthglzNLbz7Q6kOPniUFKi0N8yPr0eGPT6o0Tcb68H23TErTiLX8cbOOZMlMQQXZCj7jXorCUL/iyO53x7RG7MqE5XjrBwRSjtzfTsdWTZovev4t9YF0N4HBGaoM9QW5W040pqUjw/bhKcTWD8AEyPUx62b10E96U/1tJCjLBGsCJyOHjZv3sBbc9FuB3fQibWdgw1af4IwvIIphU0SlzeVhzJ+TVn4Vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=COfOI+IBPGmcIhYljjbFuYuswyZamDCyG0pcO6m3Cm4=;
 b=0LATTziH3G1K//mngbl+qZgMIetBAATmhu2h3AaXY7ItJoeuwCX9DRBIZSlEdkObhrbWaQuX4HwIFO767YdnwJvq3gtdAQGKe+u+8JOkMX7WxxJJNDbLqCoZqEEYk5/RRvZSatmBGnBWQWD6HKH76gVKr+xA2/abKNabjXwKAQw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by CH2PR12MB4280.namprd12.prod.outlook.com (2603:10b6:610:ac::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.28; Fri, 7 Oct
 2022 16:13:20 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::76ec:6acf:dd4d:76a3]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::76ec:6acf:dd4d:76a3%9]) with mapi id 15.20.5676.030; Fri, 7 Oct 2022
 16:13:20 +0000
Message-ID: <4e0ff179-f0c3-c06e-90cf-f43e8b7d1525@amd.com>
Date: Fri, 7 Oct 2022 11:13:17 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: drm/amd/display: explicitly disable psr_feature_enable
 appropriately
Content-Language: en-US
To: Shirish S <shirish.s@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Harry Wentland <harry.wentland@amd.com>, Roman Li <Roman.Li@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
References: <20221007042819.119692-1-shirish.s@amd.com>
From: "Limonciello, Mario" <mario.limonciello@amd.com>
In-Reply-To: <20221007042819.119692-1-shirish.s@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0093.namprd03.prod.outlook.com
 (2603:10b6:610:cd::8) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|CH2PR12MB4280:EE_
X-MS-Office365-Filtering-Correlation-Id: ac24bd2e-196a-466c-87c9-08daa87ed9af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: N16NkcUSagBmiwDPaztgfSHsylADYdvXp11qUacFKanQjTVYC2UahLVNhmYJ3Qm6T0oXwUgr8d0OXihWUFQnjLL067Ay2Xn3Ka3fA+S3XF+60177Ha+Ta5bW9dd88tkG4YppXhpEmDoC/egkigdhLtPLM/xfftJ3lINFEXGgqCXAo9XWGlzp3Dfm5raQxdfOgcgPkKBrgiOiZhblsr4SDPLH9/Ll+XEkatAp7+lGW7/2Cj079xuD4o5lcgLfGI3erheew7cu1MHJ2kYQrolky8sy39Ie5wZ5WBWFjQFutpcHTavdG0mqb/jlpBDXdcsK8H+sOcVcmrzGFDWeCvcuu3im35th3FRLcJmfz7lWentaVF9ewJbuItlXdY1FxWWCi+9/vYUvFYrAkVlhFkZrM4yerUm4h3HzQyqO1EwxI6/uMssY7St67mZLFsEyEJQDayH1Y6LDM+PirIeHMUad1NdVTysVM9aRfVtjbWolTJmGdkZErry2h+PNZkgOjoObKFw95tiVZTusjEErIoeDtAkaeG9ncu9bIDSunvXL8rFaqPkpobavvt+WdaBk/UyJ1TQJ+jULA/XrvFNMXQPl7ci8gGnt3zy8678S2Jw8G5Eh5lkqPMTqGBU3UfiM7WZG7gB4xwzTaWSMG0QmE73tGLJdN8AwHTQQcE9cgHlHSyUx/mxNYdmTGz0TRg2uHsjMgQVEEZZScPV+0P4jWh/XiTDk/m91sx4jbCY3p2mz1Xln8bWpNKOpMlhWER5gtKCWZ3H5u1bmFgI0Y/S4Hmna+AXFJFJ9nPum5E0YfRIIIaw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(366004)(39860400002)(346002)(136003)(376002)(396003)(451199015)(6512007)(26005)(31686004)(316002)(6486002)(110136005)(6636002)(36756003)(38100700002)(86362001)(31696002)(83380400001)(6666004)(478600001)(53546011)(66946007)(6506007)(2616005)(66476007)(66556008)(4326008)(8676002)(8936002)(41300700001)(186003)(2906002)(5660300002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QlIydEhRYmxrUk43ZjdNNExtd1lhbGl1M2tpL28vNHFxb0VXMkFsb3hZWkli?=
 =?utf-8?B?eW4wdU52QVUvckhWMi8rcXNZZ2dleUdtdnE0Z2FKRUowSnNNNzVPeXgrV29W?=
 =?utf-8?B?U3hTWDMvaUJVdUJxSTB6QkRMemJqUnlhZjBCNVdFRWJNVHhiWkJuUlZtUUh3?=
 =?utf-8?B?aUJJcmhRYjV0MWp1dWdIUmd0cHZ0YndRNWJscThEZFltK003Y3U3WmV4aENr?=
 =?utf-8?B?ZTZzalduL054NHdTZDJDaDNGYUVxbVhiaFhVNUlFZFJzZzh2Zm03VWo1VEtG?=
 =?utf-8?B?bkxtZjZSeG1tT0dTeGtTTWRvbVhUdzZOMVRMSzhDNXM5T2JWeVcxNytrV3k4?=
 =?utf-8?B?ZkgxVlU1RUFuT2hkeFBYS3cvRWl2VVJBeVl4aXdHS25uVzNraW5nY29Jb09G?=
 =?utf-8?B?ekRYVkR0YWR3UWFGSTYzZ2lHWldWWjEzY2FmQkRQNlVTODh3UmFNVGpCbkUv?=
 =?utf-8?B?MXRuNlF4Z0d6MmZhQWF2TXZRM1dwK3dsTmdoWUFXL01xVHFxV3dXNDJEMUVW?=
 =?utf-8?B?VXNTUGE3WElrL3B1TXZOeWYvcDAwOGdDLyszQ0o3T0hKMmY1NVFtSHJ0bENp?=
 =?utf-8?B?OWwrdjQ2YUphVU5paDU2SU5iU0x0QjJRbjQzdEJyNmtaZE1CYi9GTFpoaUoy?=
 =?utf-8?B?WGNrc0hNaFhlNUNYNDJOVFRKdjVOUEF3WjVPcXRCeGRHZEU2UGIwTzhaMGtr?=
 =?utf-8?B?MzBjLzBQK2tYQTBZRWNFTEhqNFIvSGlQcHZnMWg5aWtXYXQvOHVLcXlUZTU0?=
 =?utf-8?B?OG9ITUtRajZXczlvS0hYUVNvdzR3TGxFTEZ3aTBqbXpjWHJGZ25lcE9lNGhP?=
 =?utf-8?B?UlBXWVZUYlpLQVhiQWJYVVVtQkp1Y21YdXU4SW51MzBBKzZsKzZqWUcxUnVY?=
 =?utf-8?B?S1E3SExWYVlKUTdpOVRhRExJVFRONW1CV2VPMkZSMXJQZVV4bEh2eWFITkMy?=
 =?utf-8?B?V0pvOGJVWlhPOHZjWXFXY0VTZ0NEbFRoRkszTEUxaHpWRHJMayt5N3JtZlFN?=
 =?utf-8?B?ZjJCOTU0enZUNmR5TnNrbHNrZWxGUi9LQlZsWW9Hb0ozbUdBV2NLM1YwbUtW?=
 =?utf-8?B?ZS9TVng1SUo0ZDdaNzR0b08ySnRNSjR5ZmZGWjVxbnBCc3p2SEdpaWZGTU1u?=
 =?utf-8?B?OTZIaXBXWTU5eDdnVHZ5YTNuWitwaVBCQ3pEMkRvOWdZZG1VWWo4a04xTTNH?=
 =?utf-8?B?VjlUcFdCODZwUWUwN25vSTQwWldIR0FVdmpqY3dEeXNDdWVCRkt6YjhWZksz?=
 =?utf-8?B?Mkg0Snl5SHQ5UHFjZGJaenFBRSt3R05SYUdpczBublp3ZGk2dFZKVHFXRGQ0?=
 =?utf-8?B?MG9rWC9BQm1wMDRmMUJ0Uk43K1kwNzlXQ21jRUdLYUlsUFlZdWxoQWF1VnhT?=
 =?utf-8?B?bU9aaEY4LzhvQm1CYUZLV3Z1REIrcU1SeFd1YVpOS3lrUnBqLzVGVXBoS1Bx?=
 =?utf-8?B?czA4eWttMk1PNHNXU1hsVzZLbWQxZlpIN3UyRE90aEZsb1N4T3g0aFdic2pu?=
 =?utf-8?B?TG10VFRoSzdpdUNmbjFPdnhBV3pkVWRJdUtVK3hERE5pdnFIdkhyTGpjL21n?=
 =?utf-8?B?SGxhWUV3M09jcms4eDd4cUsyRGx2MFdaUGlnZDQxd01UNWExSmhtbU16S2tH?=
 =?utf-8?B?T3FVdHJ0SG4rRWxDSEZNY2VvNnF1RkdkajlYOE4weWNsa3B3WEg5SHl4YzhG?=
 =?utf-8?B?VERTSFpSNnpkRXhoektzQTMyZElsYVlDa0RWbm05OVlDcmUyaWNuY01kWjVq?=
 =?utf-8?B?TGRUa045MXg0Uk43UDNDOWFHUkdsRk5qRll6SUNCUU9RcXBMK2NpOStJZ1ox?=
 =?utf-8?B?S3NnZmp4RXFkVGU2L3lJdG43UjRyR3lzRDVrWGZEaS8yUmVaR2ZXZEpXQVBP?=
 =?utf-8?B?Um5vYjQzNUxzbXpZNmI4T3hTTGhrbkVRWnk1SjhJMkZRYzVna1Q2SHhOMFl3?=
 =?utf-8?B?by9ER1NnVFJtelpaZWNjQjM4bEdGeWhCZEIxTm80djE2U0dlQVJMc05uY1Y1?=
 =?utf-8?B?T0V3UlIwVzRZTVpkRGJkMjEzbExtdmtIS3p1ZmMraGVNUkViUTJVZjhkdDVu?=
 =?utf-8?B?dThJRGtnY0YrazhsQ0dvMmVCWU1zUXhJWVU5cFFVMDF4QjEvRms0QkNNTFl4?=
 =?utf-8?Q?Y5O6XDtYj4YQ9lMLfRtqTipJg?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac24bd2e-196a-466c-87c9-08daa87ed9af
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2022 16:13:19.9726 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hqPbCwxZjouQJKsdwFaHKTKcHUwsp+xlHmvRmG3v9jcDscJO0IMwGOWKJdbtFidtN0UGFJupb/tdQ6FNucTJHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4280
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

On 10/6/2022 23:28, Shirish S wrote:
> [Why]
> If psr_feature_enable is set to true by default, it continues to be enabled
> for non capable links.
> 
> [How]
> explicitly disable the feature on links that are not capable of the same.
> 
> Signed-off-by: Shirish S <shirish.s@amd.com>
> Reviewed-by: Leo Li <sunpeng.li@amd.com>

This has been a problem potentially all the way to when PSR was first added.

I think this should probably go back to stable.  The commit that last 
touched it (f4594cd1fa556) was in 5.13, but this could at least be fixed 
in the 5.15 LTS kernel and newer.

Cc: stable@vger.kernel.org # 5.15+
Fixes: 8c322309e48e9 ("drm/amd/display: Enable PSR")
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>

> ---
>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c | 8 ++++++--
>   1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c
> index 8ca10ab3dfc1..26291db0a3cf 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c
> @@ -60,11 +60,15 @@ static bool link_supports_psrsu(struct dc_link *link)
>    */
>   void amdgpu_dm_set_psr_caps(struct dc_link *link)
>   {
> -	if (!(link->connector_signal & SIGNAL_TYPE_EDP))
> +	if (!(link->connector_signal & SIGNAL_TYPE_EDP)) {
> +		link->psr_settings.psr_feature_enabled = false;
>   		return;
> +	}
>   
> -	if (link->type == dc_connection_none)
> +	if (link->type == dc_connection_none) {
> +		link->psr_settings.psr_feature_enabled = false;
>   		return;
> +	}
>   
>   	if (link->dpcd_caps.psr_info.psr_version == 0) {
>   		link->psr_settings.psr_version = DC_PSR_VERSION_UNSUPPORTED;

