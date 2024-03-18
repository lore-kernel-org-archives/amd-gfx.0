Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41BE9C54E5D
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Mar 2024 23:03:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BED1510E56C;
	Mon, 18 Mar 2024 23:03:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rJyB6Kmd";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2104.outbound.protection.outlook.com [40.107.223.104])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8455310E56C
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Mar 2024 23:03:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NUqDp1M/cNi6gcIvAJlhcCDTZVrS3VWhVCqfjhpoqVElPXYxu/fU6bLSQW0FQiApVTo6utlMbCURzQ+sLU4+XrDx0l6g+31osh1/9GW6CqjJRXkt2sf8PDX34a8eL0NjlGXpGE78kUCV+VgLoBCHryeh1fF0mVZDQX5apx15CTgSMJwKZH/HhER1GfIZPwA1HdEGfGN3ToH6NsX8GEnxsAEFQ381wimQxwny97zoayv8MOY7narchF3EQTUgByKlIrh/J2pI84KEHOCQtNCC0WKZnyuLmdSVrk+FwD8EoBTAzqbeohVfUy5L3XZiruXzS5295xtsohuzm6M9OTB63g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CGk9miGpcexfXsv4nofHL0/wylvzyozrMbXNz5GACZw=;
 b=TGPxkFeOih2HmuVvaxJtuOdjifpnUhhx4rhcVhFEK3UJKjThU/ohBf6XfrCkaWfjxYaMnDlRbMNRzLhmHRf6yZaS5bntNDLgcCEFiB4T9WWM9UjkBmMFeIA2yKy2iWSOwCKWXIf7HCI+7uASP6DmCIkY8efzas/Nd7XQUDmdzi+PHCOjijXgxLnif0qjhfwAczfONbgzdZ2vRD+05/0QwXPe1qgn9NlzkENeKKF8I2T7JGRVJx9f8FCqOUgKtLfnFCPoP2+XLpdd/lGfRb0bkrrHccZtMODFJXZFbNGoiawWIxciNegMwrQM7iMPqkhWLrpO7sdDLCqXXRt+iG4FdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CGk9miGpcexfXsv4nofHL0/wylvzyozrMbXNz5GACZw=;
 b=rJyB6Kmd5k/SCpx0PBk77ZrNHlp4wk7bvpcuuj9taQGNnwEinUUJnlQ+rR6JaCKhNdcI6019YPQGAVIG3axxygkeU1zTuV1m41at5L5jEvBrJIe4NP0WqeqMmRzBdDQ0oxUq/moP40WBTkutBf2j3FobAXNX/uvBFps9emWDHL0=
Received: from MW6PR12MB8733.namprd12.prod.outlook.com (2603:10b6:303:24c::8)
 by LV2PR12MB5798.namprd12.prod.outlook.com (2603:10b6:408:17a::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.26; Mon, 18 Mar
 2024 23:03:30 +0000
Received: from MW6PR12MB8733.namprd12.prod.outlook.com
 ([fe80::2243:aadd:acd3:3455]) by MW6PR12MB8733.namprd12.prod.outlook.com
 ([fe80::2243:aadd:acd3:3455%4]) with mapi id 15.20.7386.025; Mon, 18 Mar 2024
 23:03:29 +0000
Message-ID: <c08f0e08-941f-457f-bfb6-5abc3d6584e5@amd.com>
Date: Mon, 18 Mar 2024 17:03:25 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: Improve 'dml32_TruncToValidBPP()'
 function
Content-Language: en-US
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Roman Li <roman.li@amd.com>,
 Tom Chung <chiahsuan.chung@amd.com>
References: <20240224063939.1512278-1-srinivasan.shanmugam@amd.com>
From: Rodrigo Siqueira Jordao <Rodrigo.Siqueira@amd.com>
In-Reply-To: <20240224063939.1512278-1-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN8PR04CA0040.namprd04.prod.outlook.com
 (2603:10b6:408:d4::14) To MW6PR12MB8733.namprd12.prod.outlook.com
 (2603:10b6:303:24c::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW6PR12MB8733:EE_|LV2PR12MB5798:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: R++rePwkjR80pwDzqMliSCwwyU6fvfJE6IeICTZLKDSCS472+G4uFWSEeAG0D6H1MarZoEHjotT27DrSF/2WUDRbv7Kg+vRnE1P2kkzhekhNOqkAgwG9pVdVEsNNWeYPK5/tsksqM6WJlx7sb22Q/EUvNu0+hoFoZqYENQD86R7ICclbcqjIjI/x/t07sT7sEOt49FOpFm8g/9S5Ff0SkzZUcWzBGTxlRuJQsC5Ka0sW+5rchz6wm7+JpnOf0OqhZHf4sgoZfMaLZcmXAlGubDJnq8PugFyb3D0JiIoWw2rmYK7D1xfw8j0TO66/cAPiKLWj882PG6bZqH/OP0J6wZ5wMXJ4uhU4ZfdRtJMTOkFsVAUvN5TM5gVZzDJQ21X+Qz9xUu9SFRD2/b1k930C9d+nFbb0sqGytsl8hbBdPPjEDKlRLshr3WQO+5JQxQkSiI5aylDEbspj1kOchIGPx8i6XMUkXV8X9RYGDA29kubQ0S9jodnX3m4ABWBWAelM6/6xqE2nmf+f9j4KBtO8yf7mv0UXnahPirgT4Ndwu8rDaNlIPYG4xtZyZtYE6nQ+D9D1fmyfg5eCraTFemZNcpcoA2C74t5HhjQhi22C2kaglU8uSxpuomb0rGRN7K9cPDmAQAbv2DCMdiMJ72XmmUXpdqUpqX2QG/gGihCYSZw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW6PR12MB8733.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N2ZTdnRmWndtUnp6NHFvUTZYZmQwSXBJMStQcEs4Zm9UMEpWUGM2dXpHK2xY?=
 =?utf-8?B?bU05cVpuMHNMeWRFd3ppSjBVM2Zoc1F4b3BmTTlRT21WWjFKV1QzTzA4MzdH?=
 =?utf-8?B?MzloNUNWbVJmazF6Vk1aWS9hMU9lbWNBUmpQMWJhT2hNZXFUYml3ZlcyWllC?=
 =?utf-8?B?ekhGTXExUm1VRzUyWjhyMVB6YmNwQ3VmUUV2NXcwVVNIRUg4MmR6MllzVXZF?=
 =?utf-8?B?Y3lBdkptSW5QM3RybUdyTW1MeXkzZ2ZQRlNTV2FGUTlubTVSSGdUVldSZlVV?=
 =?utf-8?B?YVlTNTVobDNZUDlpbDJjRUs3YUhXbXdVMktwTWpsQ0J1bnJ4TDlFV3NOM09J?=
 =?utf-8?B?Ly9uTHdpMDFRTkFQSG1lOFZsc1U4Z3ZiZVVwNllVS3NEZDJ4SVNpRVFidXp3?=
 =?utf-8?B?UVFPdkpjVW0wMVVRNU56UmZNYVR0U1BPRjRUaEI1UUdYSUQrWWR2V1VlaUxR?=
 =?utf-8?B?bmlLTVJrcnVweVlnektFeGJRYUxYZzRpK2Y5eEd2aGI4N2U1UUdpT2I4Vk9M?=
 =?utf-8?B?RWtVSURFckw5Vm5pUXFyOTdpM2JGVHROTW9QcE9OZG94Q3k5TENrdXYzOE9v?=
 =?utf-8?B?ZGFiTTVtcDZ1R2t6bHhPdFMrUTFHMFVZTnNYb0hYL2U2ZTZvQzJsR3dJRzZn?=
 =?utf-8?B?bkVtMTJVM0JmS0tldnFsK1BvNEFyMW52akY3Skl5YURuYlZZWVRWQWxLb2xy?=
 =?utf-8?B?Tk9xSExRRHBwNXJvc0VIam1MWWZDS2dCZ0gvNi90WDlGbFdNb2pCOTVKRTBx?=
 =?utf-8?B?dUZhVDRSd0V1OFBOL3oyWmlYcUwwamJsVTRLSGd4SEhyb05qcnFKKzczcUZZ?=
 =?utf-8?B?L1dYaU40RmRTdmlPbTJTcG8zRTluM0ZSeUsrZXIzQk1SU0N6UWtqOGNkSUkv?=
 =?utf-8?B?eWwxSExoU2xpdjFSU1diN0lhZ3Z3d3BGZDA5L0IxNzJ5WnlFc2EwU1VxTEhT?=
 =?utf-8?B?ckVhcE9WZFhzc29qR2RTVkhzVFV4OWduVTh2TzYzSTBJbHlUUy9YRTNuOEVj?=
 =?utf-8?B?LzZJYVkzVDMyS1hWL082SSthd0VpWSt3RE5aT2hhaE40dEoreHhiMXNjaUxN?=
 =?utf-8?B?RlhpZFFuMSt0Ukl4WitmS3FkaFVVaEFaMnd4VmRwVERTMWUyMHF0QVoyZk5s?=
 =?utf-8?B?MS9mK1ZOV3NZeVVlajVlN0lXWnI5dWxVUC8rVitJdms1REpzbEdzMnB3bERa?=
 =?utf-8?B?b0dLcEE2TGZ4V1lqOGY1Q2Q2THdYQW5VVXNudytiSWFHVzEvQnN5YkdGaWdN?=
 =?utf-8?B?cWpnS3ZSZ0w2a3UxS0hzTk51anpIY2xFejRjRklXbXBCaUJHd0FHdDdqUExz?=
 =?utf-8?B?QnFncmtpYTYyN3phM0VmN0JJMmZieVBYQnhXajJOanJNQ1hBUzNxcjZjc0pX?=
 =?utf-8?B?YUtzTml6eHFwZ1BqZlIzWFoyb2xiTWw4bytSQVR0TEtSbDc0UUVhYTNQZlR0?=
 =?utf-8?B?ZjlNbndjNGtHWnIybm1kUGVROFNRWkRaUWI5SDBVVWdXR1hvTzQzeFJvYjNO?=
 =?utf-8?B?aFRibDdUTW5ka0ZUaTZCR1d4b0xGSzlEaUFJZ1BTays3dmQ0MHZJYW9nakRM?=
 =?utf-8?B?VHljYWZXMy9LNnJ2SGRJWGlnR0JuWnRsZ3NjbmZNWVU3SGtGTGYxRUxGcisz?=
 =?utf-8?B?QWlXcVpUUjBjMWd3QVJIeTlxcHR1Z1hkVFJJcFZkdlk2ekx4a2RHdklqVjJS?=
 =?utf-8?B?K2tRRU1UYmxOMkRpOEN3OEpVQ0szRHRTQjFxSDJLMmhSdm9oQkhXVkhkcnFF?=
 =?utf-8?B?eHRsQUszWHg5NWZhOUd3Mks3dExJc1NKTXprT1grWWFFZDE1NFJXc1ZRQ0Vo?=
 =?utf-8?B?bWd1RlR2ZVFtN2I0VG1HV2lkQ0NsdUphN3Fjd2RXVTlpSWc1TkdqNHpqbEVE?=
 =?utf-8?B?cEo3dzBjOVhvaWpaa2NjY0Q2elNONi9td0lkM0NmTU82aVo3NGRuejhlQms2?=
 =?utf-8?B?aExLNkpoVzVOSlBHZUFQSzBWT08zY3NVMU1jWmRRamhpZ0dNem1zclp2dG1u?=
 =?utf-8?B?aTV3cld5U1ZST1dtOW5QZSt0d2E2WlE3b0gwYk55ZFI3bERPUGtDRkJlU2o5?=
 =?utf-8?B?S2NzQXlqS1BNYVZzRWJzY1ZvQXRtVTAzUUNieWpYdVBJdHVzTXphdWV5bGc0?=
 =?utf-8?Q?8dd/ezuUn1gXTem0FBv1FrvTV?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52639ee3-f8b7-4494-d368-08dc479fa061
X-MS-Exchange-CrossTenant-AuthSource: MW6PR12MB8733.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2024 23:03:29.8225 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rikNP358QW4r5iHIkSVDGaZcYk7iSeMtfMg9L6GVMj0WF4ZQnOXny33eGwLTVHUAyJ8LBiHBpZHGJMnPKiyhIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5798
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



On 2/23/24 11:39 PM, Srinivasan Shanmugam wrote:
> Refactors the dml32_TruncToValidBPP function by removing a
> redundant return statement.
> 
> The function previously had a return statement at the end that was
> never executed because all execution paths in the function ended with
> a return statement before this line.
> 
> Fixes the below:
> drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn32/display_mode_vba_util_32.c:1680 dml32_TruncToValidBPP() warn: ignoring unreachable code.
> 
> Fixes: dda4fb85e433 ("drm/amd/display: DML changes for DCN32/321")
> Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
> Cc: Roman Li <roman.li@amd.com>
> Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
> Cc: Tom Chung <chiahsuan.chung@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>   .../gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c
> index 80fccd4999a5..54ac8242f7b0 100644
> --- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c
> +++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c
> @@ -1678,8 +1678,6 @@ double dml32_TruncToValidBPP(
>   	}
>   
>   	*RequiredSlots = dml_ceil(DesiredBPP / MaxLinkBPP * 64, 1);
> -
> -	return BPP_INVALID;
>   } // TruncToValidBPP
>   
>   double dml32_RequiredDTBCLK(

Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
