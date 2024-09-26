Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E3ADCCF9E9
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Sep 2024 09:58:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EDD7F10EB8F;
	Thu, 26 Sep 2024 09:58:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Dt13k91y";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2063.outbound.protection.outlook.com [40.107.236.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6BEF410EB8D
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Sep 2024 09:58:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IksrUABlZbiSmtk1ATQk6gHwQMWl6s/mQGR9h4pyFq4zRXCY9M7jQPfNWwwCbopO/9sff1OKZDe6L4RFO82cTVcVZ6qm4+yNKF4wTF/vcmgJ65XRbZ0mphi6bFG/s8AfS8T3lac73Y2cgil1TJmMtFykcspQXYqiBr6U3lGv4POLfCCDhfxiu475FjIzCSgbHs3FEVs2xMnwXGjbOSIr4zLhtQLiFLzSfy+n6rH3x2fhKvbDJzGlVQxhGUj9ob6i0URdwMJwf9mTPpaBlunUFvtdbXJbEvByr6c5CL0HDUIo5BPcb4OlHhcxcihOzpylZsF0+vgmLI8XSwSqFy9S8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hTjJrB5GxeCSpfLBj4KG1TUzJYjoRxFGsoj8Cec7ZUA=;
 b=Dy+P0Ba6vHE1mRoO/ME1h/WJCrfrU4HOBf8QlmEjZo67opm61jWKFFfWu0h5IKfquX15Y+vQucyEIk+XH5OK2zJ1YtCXOU8bjd4oklej14pZyl8Ein4F6wzHpcoOp5ULFIq81+xCOjYWJ9crDnYmVyNUMJuj5rwurkhpYnD/KFo/ZwmYvIyae4NvIlKnHLWUGoDKWuaG24VeFuNSC3Ely6HiR+HuXsmwNSXw+d8MwRhfz3Uzrcw+VUE7KqeylB4NIZK0qndFuq5CKsjuOvfk8nXdeB8VGObVZwu9Ew5TyLLt6240pLJEJGMSIVrxbOFFXhQt22HUc6nAtgNbkPmfoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hTjJrB5GxeCSpfLBj4KG1TUzJYjoRxFGsoj8Cec7ZUA=;
 b=Dt13k91y7IZIfxreZDhsNoxahswaovSDJkNRJI6v4HnX1SF2orPXnyyICM7MfaELTylQNa91H+ElFIJK/3Xw1PbutuloEJIxl2jLULqeh9XDkxv9ynheqzRdR0y1XL4ChehNNkXKJpLQhfRciq8YMxVUxKuB0X+9dbfpWyvLRE0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 PH0PR12MB8799.namprd12.prod.outlook.com (2603:10b6:510:28e::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8005.22; Thu, 26 Sep 2024 09:58:08 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%5]) with mapi id 15.20.7982.022; Thu, 26 Sep 2024
 09:58:08 +0000
Message-ID: <ed560dc9-8b43-4db5-9a65-ee841d35eb8a@amd.com>
Date: Thu, 26 Sep 2024 15:27:58 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/7] drm/amdgpu: Check gmc requirement for reset on init
To: "Xu, Feifei" <Feifei.Xu@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Zhang, Hawking" <Hawking.Zhang@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>,
 "Bhardwaj, Rajneesh" <Rajneesh.Bhardwaj@amd.com>,
 "Errabolu, Ramesh" <Ramesh.Errabolu@amd.com>
References: <20240924055652.2678433-1-lijo.lazar@amd.com>
 <20240924055652.2678433-7-lijo.lazar@amd.com>
 <CH2PR12MB4152398EF93FAEDC322ADBEEFE6A2@CH2PR12MB4152.namprd12.prod.outlook.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <CH2PR12MB4152398EF93FAEDC322ADBEEFE6A2@CH2PR12MB4152.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0221.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:ea::17) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|PH0PR12MB8799:EE_
X-MS-Office365-Filtering-Correlation-Id: cb3b10f8-50ce-403a-0930-08dcde11b8ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aitZK3hDSXQvSWdSazlzUGk5ZGRWbm9ZVE1IaER6ZWFDcFk0UTNCdk5QTysy?=
 =?utf-8?B?a1lsalduSWp5WXJHZUJldG9GSmVTZjlrZ254Z1ZsbnJ2RTJVTGdvejdxZmMz?=
 =?utf-8?B?MVhTaVI3TUxqRlNYSnVpak5zSVpNdi96bjlmakk2ejRkekpXQXZZWVJxd3lX?=
 =?utf-8?B?NzhWRm9QNXNmbitrWmx0VkM3RjFCWXZOM0RmN09pSm11TGpDeUJoU3lXOHdv?=
 =?utf-8?B?MVh1Wjg5dHV5QTdlOEQrT3hDWG01N2RBNHdjWjJJcFdxU3J0VjZIVS9TNUt4?=
 =?utf-8?B?OTdYT3hhcTVZaWc1V0x5RTMwVDFmR0psbUtOYWNqVUd1dmo0TEdkWUlXWXdl?=
 =?utf-8?B?T2hkcGQxSTdwbmkrQ1Z6MDg5czNRN0JUK0FrYldMS1dhelBFTklQRjdocDFp?=
 =?utf-8?B?cjc1RUxJdnRQbnZGOFYvZTFXK2VHamxCazc5ZVBQWEoyVU14NVpON2M4elJB?=
 =?utf-8?B?STJvTzJIQWJkajhISFR6dTZrejZpcSs3ckwrUng2WCtKWFZSZkVMUXFtQXdz?=
 =?utf-8?B?Rk9TNFRuR00wSzV0MlhEYyt6NzVOMjEwTFhkbm9nSmVVME1xWC91R0habHFx?=
 =?utf-8?B?cmJ1MzF2TWhXdkRxZk00R0JrVGt4RzZPaXg1aEc1Ni9SSjNadUhwcmlZenZz?=
 =?utf-8?B?YTlQbHVvaUo4MHhzdWF2SzNkTXJvZ3krbzN1bHY0bTlMSXNxeURpMFg1MTRx?=
 =?utf-8?B?blNNN3VFUDRGcjE2NytQdURXUzRWY0t0MEFGWDJOMytuWWRlSzZqNXgvZkVL?=
 =?utf-8?B?WkV6RHkyNkFEV0g1S25NcmkzdDhwc3BjSkZ1S2k4Y1JqdUg2YU5TTWRyaysy?=
 =?utf-8?B?UDE5SGNKMlVQeFBXTlZMY0hTdXlTS2l5WFRSK0ZiQm93QmtHSHc4NzBCalhx?=
 =?utf-8?B?TDhwWXR0dFJqR0gwcVA3Z0VKYlRJSkE1UEs2N1JHYXQ5ZHhldWQ2YjJBSjJI?=
 =?utf-8?B?U1BQZFlnWkE2Lzc2QmdTUk82eWtWQXdhYWpHYkRmaGdoSjZBejlFVWdsZlpS?=
 =?utf-8?B?aXZ5WEJCWDVtVnhWSjA5REtiQWNTU2lqa0JHZjhiTkJ2eEQvMjZiQUg5aHFV?=
 =?utf-8?B?T2diSTNreTF5aFZvbVBJQ2FkNTg5S3NJaXNrSi9iR2szcUxUSmlBOEY2cTB0?=
 =?utf-8?B?VDBxZVBhZzlYVmxsWHNOempyWnVnRGNvV01BRGt2cmkwa1A4dHZPbStKUG90?=
 =?utf-8?B?MFJESTdJVEFHRGpRN0pPemsyMlJrS1Z4bHFRMS9NWkkvcHQzNDVnTWFPR2Zl?=
 =?utf-8?B?WVY0dXRLUFZMUm9zY1FJVjBQRG56aUZjWG40MEM2OEp5Uyt5Tyt4emV3NjdT?=
 =?utf-8?B?QmdUVzZlRWVDcjRVV1ZkUS9KZWpUTTdWZHU5d1FIYkw1THBvRmtqbkN4d0c1?=
 =?utf-8?B?aXA3bHArYldpbXE2S0IyV3BocXYrRTRZMWJnSFBTY2o2THNFVlN4dWl1eWlY?=
 =?utf-8?B?U0JybmpCeHhucDRZMy9KQ1V6VjE3dnZ4REJZTnV3b2RKNnJURSsyTDRQUFNZ?=
 =?utf-8?B?N2NnSjF1NUxFdmViUUl1ZUtpSXFqZGJmUnVIN094Q2pQbjY3UEJncHliQ0pX?=
 =?utf-8?B?RWNwQmdRN3d2ekUrL0FpNCtiekdqUU1KcTBVOEk2MFVHODRtV3gxQUt3MDNz?=
 =?utf-8?B?VUNWd0J4OGMyTFR1b1dUYkZJVm9xdTFjSGE1d05XTi96VkdqbDZReEFmZ2to?=
 =?utf-8?B?clpaQ1E5d1ZtTGRRUGtEMTF0Q2xadUFlc0R4Q2RXZ0hrSnhOZVRpR1BnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZGlUanZEWnJ1RUd5K2pTWjY3NGRMVW9HaG9DVlNQVFNIdWxKemthdmVaN3Br?=
 =?utf-8?B?QzQxWTk5V1oxOFhuSm8wUW9jalh6S0YycEhKRVZac2Y1Y0dtajBoYUFhNjVh?=
 =?utf-8?B?djRZSGRxdEN5ak9EU0dvdENrcWUwUjAyTVQwTHh2RndlT1E1MTVzVHVQOXVk?=
 =?utf-8?B?Q2VWMGFON3M3UlFGVzVCcHYzKzVBZ3hjbldzZG1NekNSalhsTkU3bGpiRW1E?=
 =?utf-8?B?V2dSS00zTXJUc3hYUUw4NlU3SkwvNWk3eFNGZ1FXN25OMjJxd1Z6dU1mcEp6?=
 =?utf-8?B?SC9sNm9HMHNQcmhrSGY3NHhMM28raXhVWm16Qk9reWdZNFo5V1J2a2VrSlMv?=
 =?utf-8?B?WUFtc3RsblRsVFBzV1Z4bnZPMVNlOERPTHdWOXdaVHhXT0xtbURiNWFXSlF0?=
 =?utf-8?B?RFpWZWRWbFllTDlVVmxrTkJtYzl5Rkc1RmM4eXFJRStoWjhYc244SWFOa01U?=
 =?utf-8?B?bytVTnZsQzdlV0lsaG1qQ1JJSUpYUmxmTXFNZ3Z4MjV2dXhjYmNSRFl3eHN4?=
 =?utf-8?B?dm84aXQzWWROcWhIZGZyOWhtcFdMdVd1TFY2dkh5ZWprMTAxdHRwV3lZTUZQ?=
 =?utf-8?B?dVIxS0N2NytyZW9JSWRlbHVBbkdkWVdicy9OUml3N1NFWEFTQVlCVDI1OGRu?=
 =?utf-8?B?blhLaHlQVVpRa0pkMitJMlFSWXk5REpuTG9ZYjJSQ0JteXhxa1BwRkg0LzJ5?=
 =?utf-8?B?YnVQTVJWV1M5QjV1RkRtRlhTK05yNWkrNHZ0QmtqWlh3MGxTNlhtMzdqMXNY?=
 =?utf-8?B?bCtqN2hUd1E1YW1BUmxBYmlEcXZPTytuVTFEcUVHeS8yVW5sMHR2dzhpVXVP?=
 =?utf-8?B?M0hEVWwySml6YzVEY3J1T2IzYnpEMXFnSXVaNytlQUVNeVMxcU5GWW5YQ0dW?=
 =?utf-8?B?d3BUZ3NpZHk5aFB3Y1dqY1hFUWl6aWdMZXRDL2kwNGNwQWp2VGV5dnRQZHNm?=
 =?utf-8?B?blc4TWc2K3JsQms2K0hpdkdsMDVwUER6bk4vTm1ESzVkWWJKL0JVeVQrbFpm?=
 =?utf-8?B?NDB6WTlUbG1SZzUvRnZUYitHbVRodzRqUk14ajBUK2oycEw5VGpnN3BpRkJp?=
 =?utf-8?B?b2ZvalBsdjVJU3pSK2tRcFQyNThKWWxBSHl5OFpYcDNCM295WjJScHIwWWI4?=
 =?utf-8?B?K05vME5LMWpGdGJaN1gxbjJ1d2NGTW9Bczh3MmNPRDJ0ZkQ0M1hPbUdvMTEv?=
 =?utf-8?B?amJzZENYUGZ3UUNWMXRSTmFmUTBEUEpmOUZCNUs5Zy9BSkVOZFp6SXpReWdN?=
 =?utf-8?B?aEtIYkc0SXUyRHJ3S0VCc1d1V0dLd0hOWmEyODdnLzJ3dlZEQ2NGd2V6MEsz?=
 =?utf-8?B?eTk1QTVHekUxZEUrU1A2QlVQb2R4bGpIYXBCUk9GNW9jOS9FQWNLbkRNSitZ?=
 =?utf-8?B?Mk1VTEJxVXdXaVVZMnU4TWFGYkJDMVMydEpGK01hRVV0ZDZqSEdDV1ZlMnJr?=
 =?utf-8?B?ZkdLVVUrOG9LWnVDY3AxQ0hpSlBUNFJXdWJzcTZoVDVGUEhkK00zMlNoU20r?=
 =?utf-8?B?UTJhYno2VG9vVHFmVUtoMU8yLzQybnVKakpkZGt0Y1NoQ0luNnhRL1RVU3hh?=
 =?utf-8?B?bnpHditzK1ZiU0lza044dHQyazVINkFWZ1ZUT2NIbjRzeUhZaVF4TzlXcHJJ?=
 =?utf-8?B?ZmhmTzhraDkwb2tGem9ZdG15aWxMR0llZFd3MXZJUDI0NXZEcFpRb015WUZB?=
 =?utf-8?B?NUU3WTNFVmd3b3VNOWR0VGg3aU1vVWxtMHpzOVdVZ2prNkVuRjhBMGkyWkow?=
 =?utf-8?B?bm13OHF2WFFJUTdYQmJJdHAva2ZScTVjM3VSamdKbElPK3pwZEExZWpjUVJH?=
 =?utf-8?B?TFhndHByOHMyNG9SSWF6eXZTamN0QU9aWWptU0YwclozbWUwdVdpTWwvR005?=
 =?utf-8?B?a3l2RUFrdkljMWxnSnpwNEN6QnNqdkJpL1lXMlBwNFZYYmdqOHNzWEVIY0x4?=
 =?utf-8?B?Vk5kMTVTM0RiZ2ZNYUFuSmJxSjZwV2V5NzJ4dzliOXVPRkVrWXdja29vbDRN?=
 =?utf-8?B?RGdZM2hwZmwzeXVmNFhDZUZTeElKVzRWcS9ES2pMNTR0R1M2WXF2RkVNUUdH?=
 =?utf-8?B?cWJJUFNsMFl5NVh1WDZTZTA2ZTV3RzN4blZnREl4WkZOUUx0OURObGtiK1FF?=
 =?utf-8?Q?Mz7p7mGEW3Yjdlx6is9ZcQLvw?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb3b10f8-50ce-403a-0930-08dcde11b8ce
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2024 09:58:08.0961 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DpB63fDzN3IPT7JdBLV/AccxFkhShhf2fwUZrLSdAJ1RuQqGFanHsb3BvJQSuZXL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8799
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



On 9/26/2024 2:31 PM, Xu, Feifei wrote:
> [AMD Official Use Only - AMD Internal Distribution Only]
> 
>>> +     refresh = (adev->init_lvl->level != AMDGPU_INIT_LEVEL_MINIMAL_XGMI) &&
>>> +               (adev->gmc.reset_flags & AMDGPU_GMC_INIT_RESET_NPS);
> 
> Is there a corner case that reloading with a different version tos and refreshing nps change co-exist?
> 

I guess you are referring to the below corner case
	1) Place NPS request
	2) Unload Driver
	3) Reinstall driver with a different TOS (possible but quite unlikely)
	4) Driver reload
	5) Driver checks TOS version first and goes for a reset
	6) reset_flag of GMC is not set, hence it doesn't refresh the NPS range.


I think changing the order in soc15_need_reset_on_init() to check for
NPS request before TOS version check will solve this.

Thanks,
Lijo

> Thanks,
> Feifei
> 
> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Lijo Lazar
> Sent: Tuesday, September 24, 2024 1:57 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>; Bhardwaj, Rajneesh <Rajneesh.Bhardwaj@amd.com>; Errabolu, Ramesh <Ramesh.Errabolu@amd.com>
> Subject: [PATCH 6/7] drm/amdgpu: Check gmc requirement for reset on init
> 
> Add a callback to check if there is any condition detected by GMC block for reset on init. One case is if a pending NPS change request is detected. If reset is done because of NPS switch, refresh NPS info from discovery table.
> 
> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 13 ++++++++++++-  drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h |  5 +++++
>  drivers/gpu/drm/amd/amdgpu/soc15.c      |  2 ++
>  3 files changed, 19 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> index 21f1e65c9dc9..011fe3a847d0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> @@ -1261,12 +1261,15 @@ int amdgpu_gmc_get_nps_memranges(struct amdgpu_device *adev,
>         struct amdgpu_gmc_memrange *ranges;
>         int range_cnt, ret, i, j;
>         uint32_t nps_type;
> +       bool refresh;
> 
>         if (!mem_ranges)
>                 return -EINVAL;
> 
> +       refresh = (adev->init_lvl->level != AMDGPU_INIT_LEVEL_MINIMAL_XGMI) &&
> +                 (adev->gmc.reset_flags & AMDGPU_GMC_INIT_RESET_NPS);
>         ret = amdgpu_discovery_get_nps_info(adev, &nps_type, &ranges,
> -                                           &range_cnt, false);
> +                                           &range_cnt, refresh);
> 
>         if (ret)
>                 return ret;
> @@ -1392,3 +1395,11 @@ void amdgpu_gmc_prepare_nps_mode_change(struct amdgpu_device *adev)
>                         adev->dev,
>                         "NPS mode change request done, reload driver to complete the change\n");  }
> +
> +bool amdgpu_gmc_need_reset_on_init(struct amdgpu_device *adev) {
> +       if (adev->gmc.gmc_funcs->need_reset_on_init)
> +               return adev->gmc.gmc_funcs->need_reset_on_init(adev);
> +
> +       return false;
> +}
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> index b13d6adb5efd..d4cd247fe574 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> @@ -78,6 +78,8 @@ enum amdgpu_memory_partition {
>          BIT(AMDGPU_NPS3_PARTITION_MODE) | BIT(AMDGPU_NPS4_PARTITION_MODE) | \
>          BIT(AMDGPU_NPS6_PARTITION_MODE) | BIT(AMDGPU_NPS8_PARTITION_MODE))
> 
> +#define AMDGPU_GMC_INIT_RESET_NPS  BIT(0)
> +
>  /*
>   * GMC page fault information
>   */
> @@ -169,6 +171,7 @@ struct amdgpu_gmc_funcs {
>         /* Request NPS mode */
>         int (*request_mem_partition_mode)(struct amdgpu_device *adev,
>                                           int nps_mode);
> +       bool (*need_reset_on_init)(struct amdgpu_device *adev);
>  };
> 
>  struct amdgpu_xgmi_ras {
> @@ -314,6 +317,7 @@ struct amdgpu_gmc {
>         const struct amdgpu_gmc_funcs   *gmc_funcs;
>         enum amdgpu_memory_partition    requested_nps_mode;
>         uint32_t supported_nps_modes;
> +       uint32_t reset_flags;
> 
>         struct amdgpu_xgmi xgmi;
>         struct amdgpu_irq_src   ecc_irq;
> @@ -468,5 +472,6 @@ int amdgpu_gmc_get_nps_memranges(struct amdgpu_device *adev,  int amdgpu_gmc_request_memory_partition(struct amdgpu_device *adev,
>                                         int nps_mode);
>  void amdgpu_gmc_prepare_nps_mode_change(struct amdgpu_device *adev);
> +bool amdgpu_gmc_need_reset_on_init(struct amdgpu_device *adev);
> 
>  #endif
> diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
> index 619933f252aa..97ca4931a7ef 100644
> --- a/drivers/gpu/drm/amd/amdgpu/soc15.c
> +++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
> @@ -833,6 +833,8 @@ static bool soc15_need_reset_on_init(struct amdgpu_device *adev)
> 
>         if (amdgpu_psp_tos_reload_needed(adev))
>                 return true;
> +       if (amdgpu_gmc_need_reset_on_init(adev))
> +               return true;
>         /* Just return false for soc15 GPUs.  Reset does not seem to
>          * be necessary.
>          */
> --
> 2.25.1
> 
