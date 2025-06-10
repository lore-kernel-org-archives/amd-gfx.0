Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77E25C677C4
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Jun 2025 20:11:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1F0FD10E30B;
	Tue, 10 Jun 2025 20:11:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Z1Gab7oA";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2074.outbound.protection.outlook.com [40.107.212.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E522410E2EC
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Jun 2025 20:11:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QfSkIGPnkQHYL+j+vhU+Ip1/6o7QxFMpzZgEvuddahuqZp+DtwV874YVTBAzxSChkfKEqSmb7EuXo7C1VG8MJZjfddnyy13Gu04Erfuqsorj9J2vd8J8iB5JUJ1K/RCGRY0P0kiEl7oOHULb+tUdImPUqVH3T71Bu9SP1Gfci1DM1rqamEvpAE/BKKXS69LJUoQ4IAsRtOBNTBgTZuefmUko14PPwW27RsIH4F0JpAPTVXCDPfeunvr7nXVGKTZpwoxJpIMzAQBEmjjoNiQFVMafLDYKgGfLgQAyNS2ff3+T2WQLpaQ1O283HUqnWsXwRJ3K1+CiF6MfsgON98Yt0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hS2HgCcMxlTtBuFQqGGXhIQ2WDe7r1YJ6MbHyAUH2bU=;
 b=tfO4d8f++SyIzR8AENKfxsXwGkXR8nv8APj7oub4U2bDWBnzI9sIoY90YBpZ3l2zQVI1MA7XCikTNSSXymx5vp7vovPMRKSUFsnG9+S+82tI/pfBxIYv9K4F5XQrHqVc8cu0Gh9BphdGL2btsDPqfTR6lxMYHTkMc+rjFrg+LkspoWhOhsDQw1NBYkKPkd2/kflQQegdedxFfygk8w+5gDOKC8D/4SvrDM4ve9g8+Bmf1DykAaaKiGNlSQYaOM34HfXRj0mtvG1b+YNyzbxXFsjgaQjVMkJbfEMRU5nqUVjxnrHflR3lPnhKmV0DPu9+vvApzLk6we3qADh21Ss+OA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hS2HgCcMxlTtBuFQqGGXhIQ2WDe7r1YJ6MbHyAUH2bU=;
 b=Z1Gab7oAKtHp4Zf5njjG/CsQT8Ct37CVRkzrGFk7p6ZNCOmAJwSPS8oZMv04vWePEOiTpKvc59Y0jqLhOrAJKWbP+pzrM4d4dEUQh28MeO0BVb4eA644uN1CqFe5x/16wJOiUTTTr8HLInj05+uk4iZDloc6tnpI6jKS8MHM5Tk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB8476.namprd12.prod.outlook.com (2603:10b6:8:17e::15)
 by SJ2PR12MB8978.namprd12.prod.outlook.com (2603:10b6:a03:545::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Tue, 10 Jun
 2025 20:11:16 +0000
Received: from DM4PR12MB8476.namprd12.prod.outlook.com
 ([fe80::2ed6:28e6:241e:7fc1]) by DM4PR12MB8476.namprd12.prod.outlook.com
 ([fe80::2ed6:28e6:241e:7fc1%5]) with mapi id 15.20.8835.018; Tue, 10 Jun 2025
 20:11:15 +0000
Message-ID: <e8d12d1f-d9e6-4e81-9984-35606ea0e896@amd.com>
Date: Tue, 10 Jun 2025 14:11:08 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] Handle aborted suspend better
To: Mario Limonciello <superm1@kernel.org>, amd-gfx@lists.freedesktop.org
Cc: Chris Bainbridge <chris.bainbridge@gmail.com>,
 Mario Limonciello <mario.limonciello@amd.com>
References: <20250602014432.3538345-1-superm1@kernel.org>
Content-Language: en-US
From: Alex Hung <alex.hung@amd.com>
In-Reply-To: <20250602014432.3538345-1-superm1@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ROAP284CA0452.BRAP284.PROD.OUTLOOK.COM
 (2603:10d6:10:148::15) To DM4PR12MB8476.namprd12.prod.outlook.com
 (2603:10b6:8:17e::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB8476:EE_|SJ2PR12MB8978:EE_
X-MS-Office365-Filtering-Correlation-Id: 468ddce2-3d6a-4d4d-168a-08dda85af419
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Qm0yNFRLbXV1UTZWaW81K1UyKzM5TVJXT1o0SDVLWUMrekZRb2pQdGh2UlN5?=
 =?utf-8?B?RXp4NExSYnhBVWp3VVVsRnc4M3VleFdjQ3ZoUnNwSGdmZlN6WUhXZGV4d2Nw?=
 =?utf-8?B?MHhNTFJnbVpRMWpxS1NwLzZaMC9TN2dUMzRIVEErRlJSZjFHSFJwcVJHOEQx?=
 =?utf-8?B?eThIdHF4bmtqcnhUd2F2Z0lYRlZaZVhLM3pURVJjYW1qd3hLVk5pVzFOamJi?=
 =?utf-8?B?bkFrWVhpalh2cmlZRUNJQ1psdjBZU2lVSkhib1VZRnZOdHVwdmVObEJNWDQ3?=
 =?utf-8?B?N0FXNUYxck1DV3p4bE1STStZZCszMmMvWVh5d2FBVkVIeDhva1BwOHBHU0ts?=
 =?utf-8?B?ZTZ0NytyTjBHMjNqRENCRlYwQnA0aGlmcnV4RWxYRDZnTDk2a2NoZkFMQzNC?=
 =?utf-8?B?bDBabjYzOUVxYTRMUzYwVjdGVDViTzFzWFVjRWJ0Ty85dE9qckZlWFYyQzFK?=
 =?utf-8?B?K2wxZEtoY014L1hmQUQxcHRkNGNmK0c2Nk9qekp1aTErWG53OWxxd2NyYndl?=
 =?utf-8?B?czY4UlhNNGU3TzNTMVczWlhEcWtmVE00cmt1WHhMellOUzRjS3RyTVdTcEFl?=
 =?utf-8?B?bUhqRXh5bTBaS3lKWUV2bnFIcVFUYWIveVYxTkdiNGozRjc5QmJCOTBmdzdX?=
 =?utf-8?B?bG82RDNZUGdJRFg4dzE4TFg3eEdkbkJ0VEFqWktMTXhGNDVtOHBHb3NPV204?=
 =?utf-8?B?SGpMTzJoZFg4eno0eWZGSll6c2ZuZ1J6ZVBKMnJ6b1pIM2Z2ZzEvMjdzVzhq?=
 =?utf-8?B?RzVpTU9iZTlZL2MrN05JWmRSMGNudXVsRHdLUHl0UVpURThkc2QzSFlSQnRj?=
 =?utf-8?B?aFFBbEMzUmxVNUNlcGVtQ3g1RzBpRU9mOFRUM0NUSzNTL1c2Yjh1N1NBckth?=
 =?utf-8?B?QTVuREJMOFRBbFQycDg4bVB6U05qQS9nOUJXZE81bVhta0wzN2NOOEttQUc4?=
 =?utf-8?B?K2E5V3dvZlh3MDZ5TkxRZGY4OFpHNlBrcDFvanpKVnQ1NEkwQmlFS2RBRlFQ?=
 =?utf-8?B?dTZJbDhzTW85MmZRMGtoSnROTUpnU1RWcm5EM2VVY0MxMWJ5MHBCSlBzU3dN?=
 =?utf-8?B?WDJ4QTA0WWRBaCt6SXpFcWxUUjAvdXdxT2k4b2pZZGZsVkZUc1QvcUdDOG5w?=
 =?utf-8?B?QzFDV0VnbVFpd0ZmVHFvcUp2SGFTd3I2eEJ6a2crRmNob1YrS0FVSmMwVEk1?=
 =?utf-8?B?WE5XWVdHcWZkak1INlRtZHI1UG42bkFnSTdPSVZMMDh4Wm40R1U4L3VENGsw?=
 =?utf-8?B?TE5CbHFiVUtTdVJSeHYzSnVVUzBJeDNrUWpldWI5cGFHUUtDSWpXY1lvMlh5?=
 =?utf-8?B?Q3BsM05HV0xROHk1Sm9tSGNWbGtvOC9vUEZmYjZPd2JUc0JrT1hQOWZPUVhu?=
 =?utf-8?B?UDFRT2pZYkVITURqeUhkU1lZRE41VG13TEYwaEF1d2xPTUhweUlIMXN3R0RU?=
 =?utf-8?B?aTR1OU9rRmFLdjRHTU10WVZQK2xPK3dZUG5ueGxJck9tcmRQVDNsWDV4M3p1?=
 =?utf-8?B?RGRMTEtHMUw0MlR5S01OOEw2YzdIMTY4VEN2V3ZxalcrTktBSjZ0NUJXeGdl?=
 =?utf-8?B?MWllTVBLUGdla3VoZWpGNnZtbXhQQ1dKcldYZndUdnRQQzJEMUp5OU5GWkZv?=
 =?utf-8?B?b2toWk5uRTZvWEd0TmI4VXlaM21pL202alF0TjU3dE5ySGp2RHoxTUhBMmFs?=
 =?utf-8?B?clROODJpeXlqZlBjbHA4SytCdzNhd3d6NTdUSFp5WU1WYWV6QmF5U3pRUCs2?=
 =?utf-8?B?dTFyNDdzYzVpQVZRVFAvb2oyU2ZLcGl6Mnc3Rlp0VUtuUmVKY0N4c2Zscy9G?=
 =?utf-8?Q?Up/4C7/RGtez0OAc2u+K/2WuMPj81kr6+rwjY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB8476.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d3A5SUVGTk5SVFNydng1clR1cUg5OWhyOUNCY2k2WnZMNXpXZlVXeGs4bVRz?=
 =?utf-8?B?TUpOQVp4MHREY00xcStBYkF4S0xhN3NQWklSMkxMRFNZdFlmcEpZQWYxNHJX?=
 =?utf-8?B?b0dBc0QvNW1DSllBSi82Sm10Y3ZMbDBsa25JTHZoTGpVQnNKaEtnTGU5M2Mv?=
 =?utf-8?B?RlFMdldOVlMveHNpMUlTd0Q5MjFnVUQ4cmZoM1N3alBhaXE1cW1tdDJDYUsz?=
 =?utf-8?B?amg0ZkJCMW1IanprL0g2dnA5RWxhM0c0TE4wb1IyZE9QSzBkZkZYbVQ1VGRa?=
 =?utf-8?B?MkFoUWdJelAzaXE4dTZHUkFlN2ozNG04MXFDRk1nYWNrVkY2MHZxTDVWQmpY?=
 =?utf-8?B?UTMzR0pDamw4QkczTVpNRHZ1c05UVERKZVNWNE42VzF3U2V6NGVxMUsvcm5a?=
 =?utf-8?B?bUJvWlhrSU5lV280WVJuMkZUV3hoa2JhbkRGZFZpZ2JBSG03bnE1VEtqSXNQ?=
 =?utf-8?B?M0YzeWVLZlc5YXpzS0ZIZzBvNldBODdNZG91REJFcERCVFJiY1hNRllmL3hp?=
 =?utf-8?B?TzBUU1Q5c1BJNmpZblJIOUY1UG1JQmRaUTRvWEkzaVdncTVIbnlqNHFGTWIr?=
 =?utf-8?B?VTNVRUZwR293c2l2UU83emFYNnNBUmtXS0pjYUU5azRWWEh0NGJGbG5WVTFO?=
 =?utf-8?B?UmJmOFhrNENvWUpyVGVUdUFrK2VpYVhBSmQ3eVFXUGVzaFZDV0g3bForRFJr?=
 =?utf-8?B?b3BlbWcrK0RQR09mODlQZC94bG9kTjhnV1J1OHFQNWxLS3FJTkEzYm1jbXdL?=
 =?utf-8?B?RExxclpDam83ZGUzNW1rK202Ujd2c05OelF3Z2tTTnE4anNFcWpZVTFkWkxu?=
 =?utf-8?B?MXZNWDBKa0VOWnA5T01jRGRzTk1xZUNsbWEyRWZ5NWRwKzR5VWFhd00rWVQ4?=
 =?utf-8?B?WkNtRm1xNWE4TlVEU0ZVZXJ5N0Q5TndTd0w4NlFJU0VWOWRpNGx6RnlKb2Vs?=
 =?utf-8?B?OFpPd21SUVdNWExMZGkrVWtyUWRpZ0FTSXIzU05qckF5Vy9iNFFDdWR5bHFy?=
 =?utf-8?B?aUx3RVAzbkFUekVTRkZ2dGRyYXM0QVF1a0JHNktrNU5IdVFVS3B4MzFWc0FB?=
 =?utf-8?B?emN3SmtUQWdYSGg1RWgweERzNUdHRUd6bklFRTA2QlIzemdzUjlIUUthVUFR?=
 =?utf-8?B?dFp0b3lrdXl1bGN6OUZmZk50QW1QOERxbXZhdmp0dDFObkZWcVdHdFdzd1hN?=
 =?utf-8?B?cXZ1THdmc0krRkJGUzlLTCs4QnpZS2JBOS96dmp0UElpa1dBY040N3lvWlNX?=
 =?utf-8?B?c2NiQUFQQWxxZFFDaUFza0VtaDgwTkVsQ2ljNzh3LzJ1aWhBQ3puZ3I5MDd5?=
 =?utf-8?B?UUc1ZGpKMHJVK3NpdFgyaUV4cGlGREE5d0MrVHY2UmdTT1VlbkpNTk9kREt1?=
 =?utf-8?B?WTJZYTRxTE1LMWdib0JjTHBzSkNhODNCeWh4cnp1OTNjV0xtRk02ZUhyeWd0?=
 =?utf-8?B?SWlVWFJCeGp6eTlERUVjeEF0M2NCVkVoeFQrS0pBVnNydEowbnh1Qi9rVXpZ?=
 =?utf-8?B?aVc0eDdTbHdnV0dlT09ob1NkWGNkclRmNGZ3bnBRNllBYkdZOExCdWdHTmR0?=
 =?utf-8?B?aFlsQ3UzdGUwLzltWjExNzg0TUh3RDMwR0xrNVpjQytHY2NkVWlQUFRVcEl4?=
 =?utf-8?B?MGNTN3A3WE42bXZvQ0oxS1NZYjJxMFlVWGF0SGRRUXpBdzIxT1YyWWQ3UDNY?=
 =?utf-8?B?RlkrMThiOW9lVUxhSHdzMkVab2F5V2xxanZBd2RmOHF1VlBTUUdka25BcWh3?=
 =?utf-8?B?ZjJHOU83UTZWMFYvcFBKMmtYZ015MUsyRWErUEFoRi92eFIyUkExSlVmMFds?=
 =?utf-8?B?a0ZYd1BtdkZ4QUROZXdoTVlrUVVxcEhRcEc4ZytKVlpacTV5TFgrNWd3eTg0?=
 =?utf-8?B?UkhaUlpaU1FOOVlwSWhoa3N5MThsVzZsb1NTL0JoUUhrcmwrZVg0N1lYSmlQ?=
 =?utf-8?B?ZXdUT0RKVnFJcVhWN0tYWUJVNkZKc201Y1drN2lOYjNyUnUxNnhWSE0wNGh1?=
 =?utf-8?B?REVmcFdlTDgrYTBzK051N24vamhmUmJBQlR0T2dLcEh3ajNkVENPVytHdmNq?=
 =?utf-8?B?OXpGR0w0WWEvaU5BYXlVcHBTd0cyUjJST3dGSGhETVBJbHAzYUtSRTBscHB6?=
 =?utf-8?Q?UyHcxUzi0XhqypJNeFvqHq7KL?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 468ddce2-3d6a-4d4d-168a-08dda85af419
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB8476.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2025 20:11:15.6018 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TMY+Gy4sVyZ9w2tcvjTeSIevmqbZp04tMfdl+MgFPxYBw6gQsezCoNnoVgbmKsMEDPEuU6RkhrmK48zhWmaQFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8978
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

This patchset passed promotion tests along with DC 3.2.337 too.

On 6/1/25 19:44, Mario Limonciello wrote:
> From: Mario Limonciello <mario.limonciello@amd.com>
> 
> Chris Bainbridge reported some list corruption occurring around the
> suspend sequence when an aborted suspend occurs.
> 
> I couldn't reproduce this specific problem, but when I tried I found
> some other issues where the cached DM state isn't properly destroyed.
> 
> This is because there isn't a complete() callback to match the prepare()
> callback used by amdgpu. Normally the PM core will call complete() after
> every suspend attempt (succesful or not).
> 
> Link: https://gitlab.freedesktop.org/drm/amd/-/issues/4280
> 
> Mario Limonciello (3):
>    drm/amd: Add support for a complete pmops action
>    drm/amd/display: Stop storing failures into adev->dm.cached_state
>    drm/amd/display: Destroy cached state in complete() callback
> 
>   drivers/gpu/drm/amd/amdgpu/amdgpu.h           |   1 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |  22 +++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |   2 +-
>   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 125 +++++++++++-------
>   drivers/gpu/drm/amd/include/amd_shared.h      |   1 +
>   5 files changed, 103 insertions(+), 48 deletions(-)
> 

