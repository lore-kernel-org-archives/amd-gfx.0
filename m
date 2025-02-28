Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 079ECC282CD
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Feb 2025 22:04:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AA3E510ED59;
	Fri, 28 Feb 2025 22:04:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ECc+dEGd";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2085.outbound.protection.outlook.com [40.107.94.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 834DD10ED59
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Feb 2025 22:04:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dIDIGIsoxtOcbmP7hcVGdwAqDyIEOk7Gksrz2gQ/+Xy8gLcSpyxxCHtLIdXq9PzTCf3Ph6nCUlRcKLjqFV+yTZ8854u8wNuYYkiVnPVgkQtbkYj94Epq9oatNnpJ1leUpLjz/1qBIzgUEXNsT0rzGdb/n/+pUxH23RgGY4pqm1aT6Zyh0nWVXMLryUyJL95QEnfe0i7WINTZAiWUcKiXQCEltXyY9MQ2/ume0Ar+nTwfRS+tQnl2ovz6pO8EcEPZV/HST6u6gFZD0h3LieZzFy5Hsck+KVVgGyuzTvz5gWgQMU61VDTh/kaDC2fTjHQASC99lokjGiQtZTt1J5gUOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kbSLGDc5DQ2YyuY5WQy6FoBu+Xe7mrGWV9KbrxrVDBU=;
 b=e1O9YPd+itpHR5XjMw31bLL4qXZgSVn7k4spCGO7Wkzrvt4MavxPTNwhefQFxsZF3kOgWdibs6Cb+a4tu3ncosTT1CkRhKnxpjUiuAHXUWJ9UE37YyOaHxv7gX7nvTJUE/5pWcrPbyRiZ3l75cU4E2qH6BIA3NwmNa5XblR1zjc46RTCAsPoBclGmaT8MUEXprCJ3/mKqgSUPkRAyPnCOxdMjTRcPLhXU1LRmOurAgEj9ZOWeQ+Xs0g5WHV8h+ljw0ao2ZTgGi9NEu/o/u/+kpHoWP6iwD3xX39c9u5+jeeMTiXUpFkaXRpSQBLDsTJh4ij9Y4cta77tudf65Zd57g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kbSLGDc5DQ2YyuY5WQy6FoBu+Xe7mrGWV9KbrxrVDBU=;
 b=ECc+dEGdEoq02djtvQpvydCHPurPsWs0jQ2WF6VV20SkZHtqrcBkrAoY2lXG/2qxLYtjX8bJkLdrRhiV3zTVqz2Zp6bORHIY4of6/kfaDY3YM+0fVAF05N6Ds0oLvRbhu942r2xqassghPlooJuxZ9NbBh0e7MwcTHSf42ZAtL8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB8476.namprd12.prod.outlook.com (2603:10b6:8:17e::15)
 by DM6PR12MB4249.namprd12.prod.outlook.com (2603:10b6:5:223::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.22; Fri, 28 Feb
 2025 22:04:41 +0000
Received: from DM4PR12MB8476.namprd12.prod.outlook.com
 ([fe80::2ed6:28e6:241e:7fc1]) by DM4PR12MB8476.namprd12.prod.outlook.com
 ([fe80::2ed6:28e6:241e:7fc1%4]) with mapi id 15.20.8489.021; Fri, 28 Feb 2025
 22:04:41 +0000
Message-ID: <f5e942c9-27c0-4553-845a-ac05ecac3463@amd.com>
Date: Fri, 28 Feb 2025 15:04:39 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/5] drm/amd/display: Add support for custom brightness
 curve
To: Mario Limonciello <mario.limonciello@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20250228185145.186319-1-mario.limonciello@amd.com>
 <20250228185145.186319-5-mario.limonciello@amd.com>
Content-Language: en-US
From: Alex Hung <alex.hung@amd.com>
In-Reply-To: <20250228185145.186319-5-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQZPR01CA0186.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:8b::6) To DM4PR12MB8476.namprd12.prod.outlook.com
 (2603:10b6:8:17e::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB8476:EE_|DM6PR12MB4249:EE_
X-MS-Office365-Filtering-Correlation-Id: d44c1cbf-35f1-46aa-cfc1-08dd5843e686
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?elQvSzFoVlU4b2JzMGx5M2JscTgzM2RvRHVzRmE3QW5TdjN6MlY5YzVwZWVr?=
 =?utf-8?B?MXFBYkIzd3pldmJuWU93eWVVR0c0b1BRRU9jUlFNdnRsNkw2RzI5V0RXeFp0?=
 =?utf-8?B?OGhrZzBiUnl1ZXpHclVSTDRSUGVndzc2S0NtQlltZGxkUjNaSCt5SEpmQm0v?=
 =?utf-8?B?YjhGS0ZMN0ZMeVhxaS9kSHJvWlI1NzFIK0o5b01wWHZkL3g1Ti9JSVBvQXZZ?=
 =?utf-8?B?cXBkeHlxYVVWMDhiK1FHTE9DdDh5N205enZPZXl3RlBWcGNGcnVGRkRhVXpu?=
 =?utf-8?B?SjFWVGdaYUF0eUhCdzI3cDRnRUNUR2ZDRTV4VEMwSTQwcEhGUUQrOHRYTEM0?=
 =?utf-8?B?SFI4MWY4WnJTcGRSTVhSbE5yd2VBNEZsSjFGa2FpY1MxVDlVN1lMQnEwemVW?=
 =?utf-8?B?eTlKY3pSSWFRa0dNMFltTWgvcnVMVE5vVDhPamRtcXdEaSt6TTFLaHRhNDNa?=
 =?utf-8?B?MFZES1lsNU91RkdpZ3RHZGVwcDZaM3ZrQnQxY05kVG5TQzlVWUVudERjcFVJ?=
 =?utf-8?B?bnVYYTNIT3Rkdis4U0MrcHdvM29PdWxPM3FYZ3BDcE9pOFZIdkhQWC9ieUxk?=
 =?utf-8?B?ZWFzeDZrRzk0NmdvUkVIQUtZWXdSZEFXdk4vdDhqQ201VHNEVmxlS3gwMXp0?=
 =?utf-8?B?K2hBdk82MDBWMnAzYjU2ZERFeThTdEhzVWwyem1abjAyaWJWbW1jeDMwQ0VB?=
 =?utf-8?B?bUthUzYxM0dITzVXcmJHby9GYXpUdlJnWGZLMkdDRFpCTnNHTC9ma3ZLcGdE?=
 =?utf-8?B?azlURXlDbkIyYUcvNU1TUU8wL2dKdUg2Z1p6a25XSG5Ua0kvUEpaZ0ZMeFBP?=
 =?utf-8?B?T1NtUDdsdHFpcUZBRWhnZGQxUzFlTTQzSG8zakVKUkNVR3g1QW12cmhFWTNl?=
 =?utf-8?B?ZTdCay9DSzZkMWNCMlBrZTY3V2VWbHhJa2tjRnNhdFQwY1ZadmlaejlaNTli?=
 =?utf-8?B?SEIraGJmdHhkd05YdlBDbkZOMXVNcERsQnozcWF5OUtZOW5FR1lma3huajdN?=
 =?utf-8?B?UHVPZG8vM0Ezb2Mva1hnN1ZUL3N1YmJQYUlXaWJQWnNHcEUvRFoyNUs0cC82?=
 =?utf-8?B?N0Y4cHlOd05zRm52NGduenpMZGZDdXh4b3lxczh4SkJlU1JwTGhVOFVUTWxG?=
 =?utf-8?B?cjdsbVh3S1lTaXpIckdzRHF3Zmh1K1pmNm9ySU4zTzljdDhnOG91VDdpTFFv?=
 =?utf-8?B?NDhvblVlV01SWUh0NWNjc2EyNjQyN3hObUFPMkYrNEFjeC9QYW5hS1JheXEr?=
 =?utf-8?B?L3JOeDVLRHB2aUZ0bVpTOENSNGY0VFpGVXhJL1hOb1ZWSisyMWNIdUpZZVdK?=
 =?utf-8?B?emZUOC94UjdHQmRFSTA3SUsrck1lNWU1dS9oY3pnOEhXK2wzUU9nVjlIc2hs?=
 =?utf-8?B?Tk5rVHZldHlMc3U4QW1sTTNMRmVWdmRheHJDa2oydnF1WEt6SG5sQUpyM3V0?=
 =?utf-8?B?UjFYVTVTR3k0QkQ4QXFTQXA0c0pyWHVCd1k0TkRCUXZSYmhtKzRoVndRZmdn?=
 =?utf-8?B?MUhhdDVsckg2N2h2UnRvM00zclY1S2RPTkRzNFc2WUNFQjBBTVduR3VLT0Rq?=
 =?utf-8?B?UkZ4R1VQWUg1ZnhnNGlEZFk4RnJUdHN5QWxDMnJBSElZQjhUN1RRR2pEaTZ1?=
 =?utf-8?B?YlVyc3UxTUlCMUhaak1DTUlYTGRoZGdmL3Z5b3gyN0daclRXa2I5T3ZoNUVn?=
 =?utf-8?B?bGprWVhpYzZ4OXArMGs2SlFkYW1PWkdxVHd1QTNVSUtvUU5sZkZTQktjTEhK?=
 =?utf-8?B?YnQxdzZ3SnhDSk5kVUczUmhxbklxQmlDclhLaTNhUTZFTStZT1NEeDJpZmRo?=
 =?utf-8?B?L1g4UU1CcDNyQ241UjJSYUsrT0RvUmRWZ2sySU9JQUE4Sk9rRUpCWUp6djBL?=
 =?utf-8?Q?nz4neWUz/4PBx?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB8476.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NEQ5U3p3KzQyVVBLZnEzWXFROEFUeGJFN3N3TkxXak5YUUd2MHRFUit6VzVj?=
 =?utf-8?B?ekcxby9EVU5GaGdkVzBpbk1mc2xPQlpzNXhuQjJzdloxVmN2TVRyR0JJc0ho?=
 =?utf-8?B?ZnByYzluSzhKYVF6anc4bW9XRC9qcXRlQS9WVnFMK3pUVnM1Q1J3K3RpWUZt?=
 =?utf-8?B?ZkdrdStvdWMzYklSR3V0dmdqTTJIUFE5dEJsM0hmQzFlMmRyRVpFd1AwQWVR?=
 =?utf-8?B?eGgxcFFxSlFOVGRHZlRRSW5wa0RuMEgzS0ljOVE2UjQySFZ6dmlNNzRBeDYr?=
 =?utf-8?B?SXl6dy8zeXlramtVSkZsUjlScStacmZIc2pRaFRCVlUyeHBjNGFLVlNBZ2Uy?=
 =?utf-8?B?NDVISkl6QUdna1dmTVFzc1Fwa2xvbFpkc1IzTHgvOHFxMUVEZlZHV2k4a3Rs?=
 =?utf-8?B?U1BOZy9lQTQvMXdFSGh1aHo2MHNnKzZrV2hBYzBoZ2ErWTl0RmdJbzk1WVR4?=
 =?utf-8?B?TmJTeStnem4yYXRHZXJDd01XNzVjWHdrME5VdU0rTWR6U0xiSU0waGYzU3dW?=
 =?utf-8?B?RFJCM2QrTUFJNU9kUks5WVkvY2FwTW5KU0sxYnNheDlKOHBXNDIvQXhXU3JW?=
 =?utf-8?B?YlBZc0lVcm5ON0hTYk1PQmhQejZRcHdnTGxkcXJEdEhKSlF5UVJ6NDNCVzk5?=
 =?utf-8?B?TzRtU3R5SElqVmNtTHZNdGNNYmhNb0s4SDFicUVhNjYvSVNwMTVzZ0ZJUlhD?=
 =?utf-8?B?UGxTUEVTOFE2SG5LTkJRSDI3K3M1YkFoRFlDSUhKQklPZFBVN1BnVjB3R1Jx?=
 =?utf-8?B?b2NsQUJkWm0zZnFQK0tBRzRJME9USXlXVlhDOGlaL0QyVC9FTmsrMkhVL3FO?=
 =?utf-8?B?S3dkOTkveXN3UExGNE5YbldHdkVTdGd5bUZXM01ady9lUVg5M0lxeXQzVHBU?=
 =?utf-8?B?VlBPL0ljcWhVblNzbXRKK3VlWFpocFVBVmtHdXNlTWt4YllodkZkV0Mvd0dz?=
 =?utf-8?B?cnBvbzJ3bDQzRWt5OEhvaGVjOEdkNkY5UVljQ0dYZy92cWFLTkcrWEZ5ak93?=
 =?utf-8?B?akFhYmU5MmJ5M2NWTjg4VGRVQmlLaE9CazJVWWJINW9JT29mbjRHVnlQU21m?=
 =?utf-8?B?dloxU3RSZGRRSDFJVGVQajNXbXlsYTFOL0JBNVdIYXJlRDh6ZGN5S0tBQ0h1?=
 =?utf-8?B?N1Y1K21tNTVSVGQ3cS93S3JXdnhVbzhtVUFTMDZuaXNhdjZWTUUramVwb3RV?=
 =?utf-8?B?MWVjVGtvVXhQRHFaeU5MMWZnblU4NWRRbFZZTTROZjlxTTBaMVlaSmQ5ZzBs?=
 =?utf-8?B?dkNmSExYZHR6K0xiR3pSMU5mQitUTVErZWNtdW1hamlwbHZzZnJYVmRtbnFP?=
 =?utf-8?B?czF6RWkwOVFPeXQ2SmRhSXh0QTVWSWJtVWorYjRHWnh4L0h4ZEFwMHVUV3d3?=
 =?utf-8?B?dEYzUjlXV1V3dC9jc1A3bE8wN29McW45eEVZaEI2OEM2bEpNclhuS09JdUVI?=
 =?utf-8?B?bHkwZGZwYXhUYThEem5iM0F5WlpOcUpKWlBQZjQzMEN4L0RydWRsU2FJSnZC?=
 =?utf-8?B?ZHFsN3hRRmRwOGpuQ0t5bk00Y0pBbTZGbDEzNDNHVXJqZm12TTdTRzc1N1BH?=
 =?utf-8?B?YkM4VU1UN0ZjTVhaZjJlRHE0QXpVejNoMXZvdHJza0ZESTF6NUdhYmNWOGJC?=
 =?utf-8?B?NFBBWnh0cTRyQzcrb01DcVBXWXZrVzJzb2NkSnhXWTVoUWhUc29VT1hKMlNE?=
 =?utf-8?B?M0M4bDhqZVZoSVBCUnk1OHBMalpucHV1NkpQWkdWcnhFa0ordkFyU3BlZWxD?=
 =?utf-8?B?N24yeGR3ek5YQ0IvQm4zLy9adGFlaC9tVTRmWHZ0b0dEZ2dBcjBsWkNnMWI1?=
 =?utf-8?B?N3FoaWc4QUwwM1V5eEtSanVsTmptc3lub2RGMHFpeWJUaTZMWkd3UTF1NlAy?=
 =?utf-8?B?V1pxV0lyaExOelQ3cStSZXJHNVI5RkZKWUdmdVZIRENFeWx4aTRvSm5uMEFK?=
 =?utf-8?B?K1RWcHV1NlZFNjkxay9nSkIrNVVPOEFvbEpFWkhLc3FjV3VpZU4wa0daYWMy?=
 =?utf-8?B?U1JqL1JYOUp6cXJWZm9PTnNCVVV6WXNVK01NamNLZWZHd25YbXZnMXQ0WVBQ?=
 =?utf-8?B?L3MxRnI0OTRrWUVzNWZLZ0x0M29uVWNPTDRxQnYwU3c2ZEloeWJFbEZSdk56?=
 =?utf-8?Q?HKY+J1bCiAj2bpt1ZKAbj0W9t?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d44c1cbf-35f1-46aa-cfc1-08dd5843e686
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB8476.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 22:04:41.1360 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FsX7YzWThn4w/nwjzDZVYkjI6pBAZ4KGIi8PFz/ze3HTmaGhnCETvolwgZBVbNHKd7gBdhw12sKe4tC/hNJV2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4249
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

Reviewed-by: Alex Hung <alex.hung@amd.com>

On 2/28/25 11:51, Mario Limonciello wrote:
> Some systems specify in the firmware a brightness curve that better
> reflects the characteristics of the panel used. This is done in the
> form of data points and matching luminance percentage.
> 
> When converting a userspace requested brightness value use that curve
> to convert to a firmware intended brightness value.
> 
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 25 +++++++++++++++++++
>   1 file changed, 25 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 61d626914590..b252c67f2bc4 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -4759,10 +4759,35 @@ static u32 convert_brightness_from_user(const struct amdgpu_dm_backlight_caps *c
>   					uint32_t brightness)
>   {
>   	unsigned int min, max;
> +	u8 prev_signal = 0, prev_lum = 0;
>   
>   	if (!get_brightness_range(caps, &min, &max))
>   		return brightness;
>   
> +	for (int i = 0; i < caps->data_points; i++) {
> +		u8 signal, lum;
> +
> +		signal = caps->luminance_data[i].input_signal;
> +		lum = caps->luminance_data[i].luminance;
> +
> +		/*
> +		 * brightness == signal: luminance is percent numerator
> +		 * brightness < signal: interpolate between previous and current luminance numerator
> +		 * brightness > signal: find next data point
> +		 */
> +		if (brightness < signal)
> +			lum = prev_lum + DIV_ROUND_CLOSEST((lum - prev_lum) *
> +							   (brightness - prev_signal),
> +							   signal - prev_signal);
> +		else if (brightness > signal) {
> +			prev_signal = signal;
> +			prev_lum = lum;
> +			continue;
> +		}
> +		brightness = DIV_ROUND_CLOSEST(lum * brightness, 101);
> +		break;
> +	}
> +
>   	// Rescale 0..255 to min..max
>   	return min + DIV_ROUND_CLOSEST((max - min) * brightness,
>   				       AMDGPU_MAX_BL_LEVEL);

