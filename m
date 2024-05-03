Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF46BC4345F
	for <amd-gfx@archiver.kernel.org>; Fri,  3 May 2024 17:05:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4C9C7113176;
	Fri,  3 May 2024 17:05:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jcTzT/AZ";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2087.outbound.protection.outlook.com [40.107.243.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C4085113176
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 May 2024 17:05:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PsahXO4iZhmDC/W5zNjee+Pi9Jis2Eb9yDPTPZR/8j3Oq+qJ4cyH88UHkJxXYWCJFsHJpmNAvWeHrsG8dqowMeX8BJmqslg52rnTVksvaCMxShPzczFw7tkBUt9Lt/zldp1EOw9mZVNGoCqYEp7PcZkLvhn6ojXPrgGWOpIUvXPvEXOKaERLp7bR0YQ9gJmpghK1SuYYoIAn/K1GMX7Sa5H5MkV4R3ihtI6ZV2AemIb1dV2cEUFumWRjmcloIEfrlfukv9eJZLB7huhs6X+mov6JJ6GZ9efIP+uEtand1Z94NCNLkoh9ZjAL+FfJqui7oYQ+jRMxzkrMUpHy2guI2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jjLAD2iguh/HQbyYLExGQwl6UJRpaLZVMVlggLFVaaE=;
 b=T23/pGyLfmg8tu7NhHU4rW6zxw3xinlCBwUxmoFiG3iRanVGsHf6wAwXcZIeqrSdfdI4wO9CHDIxG68Kg4nw06XEFLuTic9z1JpTarvzMrGRFN6KOhq0g95RNELLfN/x7oiUKHE+tB4ltcip+JgBN9uolzJGluU3Mx4po1JhdbBInVus/pDmRyfc92v03o60Q8kSFYrEIgoN/GNO+C8YfyiwkUQUY04jgjJzuIOL3eNecOl6MJZ/ixRE7BehT7yTkmqseZuiUk0qrel3oOtvy2Jb9GAj1JPq4JPD80nMPtBNY7duYHH//BSlaK9AM/740MIjUlcV3cIE30byGmnftg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jjLAD2iguh/HQbyYLExGQwl6UJRpaLZVMVlggLFVaaE=;
 b=jcTzT/AZREffJtIaNettVklQAO8HGMm0Io53w3XYI6EDNiTf8PwCP6THvDu5fskRilP0RLHWho6rGwyJ9xZoJEv/EoRVeEk8nuwcsIu+t48g/nWtISqms6suFIO5oFzOE9oAh3/1wvqZYm146+uWeM/F4A5/yZH1qOFRnwcNQD4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4342.namprd12.prod.outlook.com (2603:10b6:208:264::7)
 by DM4PR12MB6133.namprd12.prod.outlook.com (2603:10b6:8:ae::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7519.35; Fri, 3 May 2024 17:05:36 +0000
Received: from MN2PR12MB4342.namprd12.prod.outlook.com
 ([fe80::c55f:19e:6896:cf3]) by MN2PR12MB4342.namprd12.prod.outlook.com
 ([fe80::c55f:19e:6896:cf3%5]) with mapi id 15.20.7544.029; Fri, 3 May 2024
 17:05:36 +0000
Message-ID: <a46b64c1-6317-4915-a595-7e0ab346ddb8@amd.com>
Date: Fri, 3 May 2024 22:35:24 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: Splat during driver probe
To: Alex Deucher <alexdeucher@gmail.com>,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
References: <168605a4-fcb9-4bc5-9404-c285964fc6ac@igalia.com>
 <CADnq5_MXb3Vxs9+9+HG+VDvD=8cgg4fsJ-HqJx-sM-WHVHMsuA@mail.gmail.com>
Content-Language: en-US
From: "Paneer Selvam, Arunpravin" <arunpravin.paneerselvam@amd.com>
In-Reply-To: <CADnq5_MXb3Vxs9+9+HG+VDvD=8cgg4fsJ-HqJx-sM-WHVHMsuA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0221.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:ea::17) To MN2PR12MB4342.namprd12.prod.outlook.com
 (2603:10b6:208:264::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB4342:EE_|DM4PR12MB6133:EE_
X-MS-Office365-Filtering-Correlation-Id: 8bc7f773-18f4-44b7-e5ce-08dc6b934004
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?L0JXYjIwWmhOOXRQdU9HUmdRME1tSmNsUWhLTlIreS9qcEhLT3BnL3JQdXh2?=
 =?utf-8?B?dFE0MVk3WlhJeHF3U1lEcjNWY3ZCb2JBU1F3K0xaNCs3OERUL0g0NXBYN3lG?=
 =?utf-8?B?NFV6S2VuSlZXU3pwUFZoY2kveURMLzBVaHF1S2dEYmN6WVY0Y0syWDk5U3dj?=
 =?utf-8?B?QkhuVlJNR2RBcHlubFpjWFNYUm96VkV5OEZsN1hIbG0zSUVKUlJITXFVT1R0?=
 =?utf-8?B?VGZxZjdPNkkxditWUGE4UFNBeTF1d1R3bmtLNFU2RDV0M2tObFJ0TDU2NCtJ?=
 =?utf-8?B?eGdkQ2FWYWk1bzVsaWR2SkZwRkNaQlZkVW4zcjE5bTliTEtuN0QyVnNJK1Na?=
 =?utf-8?B?cFVvWnplVlNWbC9HdmhpZGdzMmZMRUdpWTFPbVVKSGJtdkltRFJHUWUwYm1P?=
 =?utf-8?B?bGVJZ0xjbHA4a0x5UnVyVnZLUnUreTd1VzJpWHVIcUU1ZEJ3QVd1bDVHZXFi?=
 =?utf-8?B?dkk4djQ4VWpYSHI4YVhvWDI5MURDTzEvUXRyYzBOUnA5cE1pL3I2KzBYL3Js?=
 =?utf-8?B?aE9DNVVwRzlWRnAxVU4wc0lnMVVpMmdXTnVpV2FGeVk5R3ZaMUIvVzJSejRi?=
 =?utf-8?B?UEdZeHQvV2tCWnBpQzZoL1ozVkR2NUkvVkcyci95eXFvTHMrTVY3NlRDeGU1?=
 =?utf-8?B?ZWpRdysyMFRIVklGb3JLNjFSUFdxNFJUWVg3WUVUVk1PK29qZVpLeGg3eVVZ?=
 =?utf-8?B?dmdhdjZQbE5idU9KTUhvRy9Gd3FGVEpFT1E0RTFoeVp3cktPNUZVTGtEa24v?=
 =?utf-8?B?ajZyQ2tDS2FLRngvczNtUlNhdFlyREdnQ1hibUhDYzZvOXROcWRGbVh0RElo?=
 =?utf-8?B?VWRlZE0yUVByVXNYMWtjUExkd1ovV1lMNFQrak54NzFzOVc1bDNlc0R5QU8y?=
 =?utf-8?B?UzdXSm5Ib1VtQTNaaFdqQy9yTEU3cTZXRWh3dFVQajFQaVl1VHZEVVpVYXlV?=
 =?utf-8?B?dUY4Z21rK0FIKzJOWUt5K28yOXp2U1kzNENVRzJheDNLNlU4SnBEd3g4YmdR?=
 =?utf-8?B?UDN6Q2MzVkkycXFJTkpVbDVDQW1GRGUySW1RNGxReDE3YXpvSHplMzlOOFZ5?=
 =?utf-8?B?OGdqd3JKWFFVemc4aS9HT2JKbzFHNXk5eSt4eW5LNXZkcW5COHBCT0VNWHpO?=
 =?utf-8?B?bG9iK1B5OFB2VGx4ZWZrN244S2VKbEFac2NRZGZtMkZRc1NXd1UzN0NxdFJ6?=
 =?utf-8?B?YmFlbVZlM1lMa0NoQlduTTR2b2tydlRRdUIzWm9JaVIrbDVydGtOeWJobU5s?=
 =?utf-8?B?eFJ3bkxoRDBVTGJmVURkRWdWYXFVZ0psWGRSbnRDQkJ4cXJNYTJmbEQxMFdD?=
 =?utf-8?B?UmdwbU53YVhCR2RkTjJONWQxOFNpMW84dGdnRzBreWJRRk5xVlBwdUpzbWd1?=
 =?utf-8?B?QS9UOU02OUttMGVRNzBKYWtzdW54dWZaWi92WE9Qb0g2YWNBTytQYmNaUGFj?=
 =?utf-8?B?ZU5CNzB5eUtWdFI1Yk8vb2U4YkxFWHhLaFBYRnNsVnF1QnFWc0pCTUM2eWVr?=
 =?utf-8?B?eHFDWlZNQmdnLzkxTGJuM0VRYWpHUyszKzVsSjAvSE1wRlc2aGtQdjQvUXR5?=
 =?utf-8?B?VkNzcHN4cWFDM3BueGxqR2F1bWVKdkdFYitKTG11dTltemNnOHMwVEZRclBD?=
 =?utf-8?B?UDZ3MFlPNG9CSHRyZXhVN0dTaHRHQnFDM05iVktDVVRPVjZDVUdSNU5kL1B4?=
 =?utf-8?B?RERyQ1ZSQitUaDFPTVk5Qk8veGx3VFdFcEpjSXMrUWo0Um5GdUVpTkxRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4342.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NVhzc2RsWUYwLzE1UHFWNVB6SDBNMFlsZTgrd28zeTlacHVWMFRZM2djTTgr?=
 =?utf-8?B?ZEVsRGlsazhtU3N0U0d5dDZWWXpNbW1FbXNLcXhUZmxNZFZSd2xIem1ySU54?=
 =?utf-8?B?b3NEUXNlaHlxaS85eEZwblVKSThmY2ZGZ2cvRUdibVVRbmV1cVM3eFBQTyt5?=
 =?utf-8?B?NGt2akZtbmV3Rmd6anZRbmZYczN3Y08yM0YwenZFcHUwRG5JT1F2WEo4NWIr?=
 =?utf-8?B?K0tuQVFPZEttVnA1U0JnUXEra202ZTA5bG1ucFZzOUp2MFZ6WjVPWm1xVFh2?=
 =?utf-8?B?UEU2dlZPa3doTUpjNHlyMko0YVlOZHZ5amxUU3daQ3p4RklOVTFsL2YyTXB6?=
 =?utf-8?B?MlZRTHNIS1BxSXhiRjUycFdOTXF4MWluV1l2N0JCeFk0Um1QNEp3UFo0NGQw?=
 =?utf-8?B?Zk84S2tiZEZmUUpPS09vZjhwSXBqZ2ZKWGdJZ3hVb2d1YmZiaWYzWjI1TS85?=
 =?utf-8?B?SUNFQ1NybVRQV1NCMTNBS2NvcUxkRVByb2k1eTJGQzFVdWtkd0JqZnowQjA4?=
 =?utf-8?B?cmpmWG5UWWJ4aGlPb29Cem1BMjlndVEzd1NhbExvYzRLUGNkM3ZlNHE1UXFw?=
 =?utf-8?B?WS9QSitva1BQRVJ6WFhFcTFZOWNSOXNrYlFHQnVIYzdiZG5JVys5Ty9UYncr?=
 =?utf-8?B?b3pPdHRpbzRPSUNRVjNTaWZyU3k5UFk4Tk5BdVBSYzJUYW1LV2RIYVViUmV4?=
 =?utf-8?B?RXppQ0h5UTlQbnF3RFlKL2dKZ2FYNFA3SWUxWWtVRDVvUUNDdGVYQ0EyTTFa?=
 =?utf-8?B?dWlQb1RSUldBb3R4dmRuaW90MzAweUd3azlWOFRGQVg2MmovUHVCVDJSdGFj?=
 =?utf-8?B?cGthSHVZUjZEL2xaNGVxSG84Z1BuQ0VMRysxNmxwRzFPVnRyTE55aUt6bVpZ?=
 =?utf-8?B?eU1QMzJENkhtY0NkS1NzUUNuWGpnYTF1aHNYaTF4dVhqanRUZDJhNWFjSXpI?=
 =?utf-8?B?Q3NsNGNiY3V3amRUeFlrZHNkN1diQmVzWVNQRVpXZWpiZ3dUNXR5QmxPNFdw?=
 =?utf-8?B?akp5dkFGYjFicC9CV3VqTTRwdUhVeGdqbUx0NHY5ZjErNHZHZTZoN3JreFVV?=
 =?utf-8?B?dWt5M2VhK3g2bXlpN0d1OWIxbkMxSi9SYVdUMVR4QU9pdU1KekdwOE9PN1FW?=
 =?utf-8?B?Z01ETHZVMWhIMk5YK0NlWm5HOVZaL3ZSZTIxZld3MjVuVjVQb0NpUHRBTE5q?=
 =?utf-8?B?TmZrV3VpZjN6WFhIYVgyR01iQUZBOUg5MDd0TkkzUExla2hDV21zank5Z2dT?=
 =?utf-8?B?UzVEOUpCTGpjOTE2S3B0ZHZSRmhLRVNZbFBGMzVQbTdRekNNRnRvZ2JESmkr?=
 =?utf-8?B?L3NoUTNSamJsdjJQeTVVWUtLalBzMG5hZkdiWUJQRWN5SHRVWlRsaTJyVC93?=
 =?utf-8?B?SmtaaVNhRmtyM0MyL1RLQU9ZTkZDZU5KeWkyak9qSnpQaHQ1azRMZ1RMcTNI?=
 =?utf-8?B?Y05XUEU1WGgwU2ZnZXVNQ2drTHNMS2VLT1o0NzB6WjBzRnA0dk1IRlQ5Znp6?=
 =?utf-8?B?elQ5dGFoQndONFdRclZ2YkduMm9jOXRKLzZuU2MwbWVzeVRPazVrU25raWdO?=
 =?utf-8?B?L1lpNHZVbGdtQSt1WUk5Y2pXaU83TlBLWTJJK0hGbWN3cUhDd01acFA1bERJ?=
 =?utf-8?B?SVBwVEhtMXNtMjd1ZzNzUkUvb0ZCZTIyb3RISHp3VGlNNUlzVmFKNmVvQU5F?=
 =?utf-8?B?aTlFY2wrYW5zeVhtU2hFMU83ZnVpK0xmTzkvQkxjQ0poUVIzWnNLNUZKSVBT?=
 =?utf-8?B?VEw1akpMY0x5Y3Q2bFgvaVQzUXhLa0lJNThDQnpMc1Rlemo3MGpxWjExN2xs?=
 =?utf-8?B?cTF4UHQwMjRsYlZtU3k2Y2ZhUmFsYzFMcHBpaEZxWmZYMFpWMVlxcDN4QkdR?=
 =?utf-8?B?NjFvUnFpTUs3Q2xkRGt2RkVrRFdxZVlaT2NQajl4a2Z2enFtRkVnZEt3eWts?=
 =?utf-8?B?ejJYVDhoS2dabmNoSEtCYVhsMnBka2hyV1RVMTUwWk5zd0hzZGFtOGpvcVFV?=
 =?utf-8?B?L3dXNDhmMTdCVjh1T2hpcG9EaHZwckFCTXRqeEJOeFBrUU5SNG4veUYwT00w?=
 =?utf-8?B?andXUDc2Z3U2aTVXMU5pWWV4YWxpQ2RHUHpLb1AvVXEzZFpBamlmdUViRStT?=
 =?utf-8?Q?MWiuDrYoFbfFBy3wivVwKALfA?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bc7f773-18f4-44b7-e5ce-08dc6b934004
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4342.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2024 17:05:36.0043 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oPb4Cv7JokAo1X244SlI/26pJy6WlroB8GyYht043baBLVSmf0m67b0DaG4jDHQQjpHInqCETifg6bxh8T6wBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6133
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

Hi Alex,

yes, this is related to memory clearing changes. This is a known issue.
I am working on a fix.

Thanks,
Arun.

On 5/3/2024 6:46 PM, Alex Deucher wrote:
> Possibly related to Arun's new memory clearing changes.  @Arunpravin
> can you take a look?
>
> Alex
>
> On Fri, May 3, 2024 at 9:10 AM Tvrtko Ursulin <tvrtko.ursulin@igalia.com> wrote:
>>
>> Hi,
>>
>> I tried asking on #radeon yesterday but no takers. I was wondering if
>> the below splat is already known or not.
>>
>> Appears to happen due amdgpu_bo_release_notify genuniely running before
>> amdgpu_ttm_set_buffer_funcs_status set the buffer funcs to enabled
>> during device probe.
>>
>> I couldn't easily figure out what changed.
>>
>> Regards,
>>
>> Tvrtko
>>
>> [   11.802030] [drm:amdgpu_fill_buffer [amdgpu]] *ERROR* Trying to clear
>> memory with ring turned off.
>> [   11.802519] ------------[ cut here ]------------
>> [   11.802530] WARNING: CPU: 5 PID: 435 at
>> drivers/gpu/drm/amd/amdgpu/amdgpu_object.c:1378
>> amdgpu_bo_release_notify+0x20c/0x230 [amdgpu]
>> [   11.802916] Modules linked in: nft_fib_inet nft_fib_ipv4 nft_fib_ipv6
>> nft_fib nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_ct
>> amdgpu(E+) nft_chain_nat nf_tables ip6table_nat ip6table_mangle
>> ip6table_raw ip6table_security iptable_nat nf_nat nf_conntrack
>> nf_defrag_ipv6 nf_defrag_ipv4 iptable_mangle iptable_raw
>> iptable_security nfnetlink ip6table_filter ip6_tables iptable_filter
>> cmac algif_hash ramoops algif_skcipher reed_solomon af_alg bnep qrtr
>> mousedev intel_rapl_msr ath11k_pci(+) intel_rapl_common mhi
>> snd_acp_sof_mach snd_acp_mach snd_sof_probes ath11k snd_soc_dmic kvm_amd
>> cdc_mbim qmi_helpers joydev hid_multitouch cdc_wdm snd_sof_amd_vangogh
>> snd_sof_pci kvm mac80211 snd_hda_codec_hdmi hci_uart crct10dif_pclmul
>> amdxcp i2c_algo_bit snd_sof_amd_acp btqca drm_ttm_helper libarc4
>> crc32_pclmul btrtl snd_hda_intel snd_sof_xtensa_dsp btbcm ttm
>> snd_intel_dspcfg btintel polyval_clmulni snd_sof drm_exec
>> polyval_generic snd_hda_codec snd_sof_utils gpu_sched cfg80211 bluetooth
>> snd_pci_acp5x gf128mul cdc_ncm
>> [   11.803070]  sp5100_tco snd_hwdep ghash_clmulni_intel snd_soc_nau8821
>> snd_soc_max98388 drm_suballoc_helper sha512_ssse3 cdc_ether
>> snd_acp_config drm_buddy atkbd snd_soc_core aesni_intel snd_hda_core
>> video ecdh_generic crypto_simd libps2 usbnet cryptd rapl mii wdat_wdt
>> vivaldi_fmap pcspkr snd_compress i2c_piix4 snd_pcm drm_display_helper
>> ccp snd_soc_acpi cdc_acm rfkill wmi ltrf216a 8250_dw i2c_hid_acpi
>> snd_timer snd i2c_hid industrialio soundcore hid_steam pkcs8_key_parser
>> crypto_user loop fuse dm_mod ip_tables x_tables overlay ext4 crc16
>> mbcache jbd2 usbhid vfat fat btrfs blake2b_generic libcrc32c
>> crc32c_generic xor raid6_pq sdhci_pci cqhci nvme serio_raw sdhci
>> xhci_pci xhci_pci_renesas crc32c_intel mmc_core nvme_core i8042 serio
>> spi_amd
>> [   11.803448] CPU: 5 PID: 435 Comm: (udev-worker) Tainted: G        W
>> E      6.9.0-rc6 #3 dd3fb65c639fd86ff89731c604b1e804996e8989
>> [   11.803471] Hardware name: Valve Galileo/Galileo, BIOS F7G0107 12/01/2023
>> [   11.803486] RIP: 0010:amdgpu_bo_release_notify+0x20c/0x230 [amdgpu]
>> [   11.803857] Code: 0b e9 a4 fe ff ff 48 ba ff ff ff ff ff ff ff 7f 31
>> f6 4c 89 e7 e8 44 e5 33 e6 eb 8d e8 dd dd 33 e6 eb a7 0f 0b e9 4d fe ff
>> ff <0f> 0b eb 9c be 03 00 00 00 e8 f6 04 00 e6 eb 90 e8 8f 64 79 e6 66
>> [   11.803890] RSP: 0018:ffffa77bc1537568 EFLAGS: 00010282
>> [   11.803904] RAX: 00000000ffffffea RBX: ffff8e1f0da89048 RCX:
>> 0000000000000000
>> [   11.803919] RDX: 0000000000000000 RSI: 0000000000000027 RDI:
>> 00000000ffffffff
>> [   11.803934] RBP: ffff8e1f6ec0ffb0 R08: 0000000000000000 R09:
>> 0000000000000003
>> [   11.803948] R10: ffffa77bc15372f0 R11: ffff8e223ef7ffe8 R12:
>> ffff8e1f0da89000
>> [   11.803963] R13: ffff8e1f0da89180 R14: ffff8e1f6ec0ffb0 R15:
>> ffff8e1f6ec00000
>> [   11.803977] FS:  00007fa2b600b200(0000) GS:ffff8e222ee80000(0000)
>> knlGS:0000000000000000
>> [   11.803994] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> [   11.804007] CR2: 000055cac2aa7080 CR3: 000000010f818000 CR4:
>> 0000000000350ef0
>> [   11.804021] Call Trace:
>> [   11.804031]  <TASK>
>> [   11.804042]  ? __warn+0x8c/0x180
>> [   11.804057]  ? amdgpu_bo_release_notify+0x20c/0x230 [amdgpu
>> 03b1dca7e09918e3f45efb1acdfc90682f73e4c1]
>> [   11.804456]  ? report_bug+0x191/0x1c0
>> [   11.804473]  ? handle_bug+0x3a/0x70
>> [   11.804485]  ? exc_invalid_op+0x17/0x70
>> [   11.804497]  ? asm_exc_invalid_op+0x1a/0x20
>> [   11.804517]  ? amdgpu_bo_release_notify+0x20c/0x230 [amdgpu
>> 03b1dca7e09918e3f45efb1acdfc90682f73e4c1]
>> [   11.804894]  ? amdgpu_bo_release_notify+0x14a/0x230 [amdgpu
>> 03b1dca7e09918e3f45efb1acdfc90682f73e4c1]
>> [   11.805277]  ttm_bo_release+0x115/0x330 [ttm
>> 39c917822ce73b2a754d4183af7a0990991c66be]
>> [   11.805303]  ? srso_return_thunk+0x5/0x5f
>> [   11.805315]  ? __mutex_unlock_slowpath+0x3a/0x290
>> [   11.805332]  amdgpu_bo_free_kernel+0xd6/0x130 [amdgpu
>> 03b1dca7e09918e3f45efb1acdfc90682f73e4c1]
>> [   11.805709]  dm_helpers_free_gpu_mem+0x41/0x80 [amdgpu
>> 03b1dca7e09918e3f45efb1acdfc90682f73e4c1]
>> [   11.806172]  vg_clk_mgr_construct+0x2c4/0x490 [amdgpu
>> 03b1dca7e09918e3f45efb1acdfc90682f73e4c1]
>> [   11.806645]  dc_clk_mgr_create+0x390/0x580 [amdgpu
>> 03b1dca7e09918e3f45efb1acdfc90682f73e4c1]
>> [   11.807112]  dc_create+0x28a/0x640 [amdgpu
>> 03b1dca7e09918e3f45efb1acdfc90682f73e4c1]
>> [   11.807567]  amdgpu_dm_init.isra.0+0x2e1/0x1fe0 [amdgpu
>> 03b1dca7e09918e3f45efb1acdfc90682f73e4c1]
>> [   11.808025]  ? srso_return_thunk+0x5/0x5f
>> [   11.808037]  ? __irq_work_queue_local+0x44/0x130
>> [   11.808051]  ? srso_return_thunk+0x5/0x5f
>> [   11.808064]  ? __wake_up_klogd.part.0+0x56/0x80
>> [   11.808077]  ? srso_return_thunk+0x5/0x5f
>> [   11.808088]  ? vprintk_emit+0x18c/0x380
>> [   11.808100]  ? srso_return_thunk+0x5/0x5f
>> [   11.808114]  ? srso_return_thunk+0x5/0x5f
>> [   11.808125]  ? dev_printk_emit+0xa5/0xd0
>> [   11.808138]  ? rcu_is_watching+0x11/0x50
>> [   11.808172]  dm_hw_init+0x12/0x30 [amdgpu
>> 03b1dca7e09918e3f45efb1acdfc90682f73e4c1]
>> [   11.808623]  amdgpu_device_init+0x20b3/0x2870 [amdgpu
>> 03b1dca7e09918e3f45efb1acdfc90682f73e4c1]
>> [   11.808998]  ? srso_return_thunk+0x5/0x5f
>> [   11.809016]  amdgpu_driver_load_kms+0x19/0xb0 [amdgpu
>> 03b1dca7e09918e3f45efb1acdfc90682f73e4c1]
>> [   11.809390]  amdgpu_pci_probe+0x15d/0x490 [amdgpu
>> 03b1dca7e09918e3f45efb1acdfc90682f73e4c1]

