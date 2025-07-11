Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34615C83F1A
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Jul 2025 08:08:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D1FE610E9C8;
	Fri, 11 Jul 2025 08:08:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nuSNSkqm";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2081.outbound.protection.outlook.com [40.107.236.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 99C0610E9C8
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Jul 2025 08:07:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=byzxUhk56+hLix2kRNTv5Bgphjqek6BSFbySGYGGZOZgw3P6uUE8Oz8YAUf/roOMRaNJ4tm6X78uKukVfHcTLWK6KDXcyGKgjo/KQXksZ5ThdW7OkfcSAww00wcBdcVbIUIgqj6hbysCpuIUYYfK2LQYwpMOdtY7WeVkbcop9OY2soQ+3VrAVVpE/LPJ8kbLhnpmw559T6XOxxhTkVuKGBDWbAfrCmLKaWU9ENAzCOuKLxt8BEWVrJw/A9+C8uEEweu1Z1Sq4bDtGBQrl9KuCS1ccaRZUa+ZZbqEcCLEz9Ph1Vkh3ZB1C6lCDW0kBDLg3NAjFUD2NHy6NZu6Ymnrmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LlMxP/23UWCa+zmRybeb9+odgu6NsLad5hWpGnVY4eg=;
 b=iBzIT8g1+Q6cGwmYgJz3Hji5+oV2LA+fvSnrZuo/WTmTAGFvIRXoxhdfZHthMoIWJVShbexpzL42MovPIpohkShgZWjmlItSSX5/KGxK+VGtiXPdSTWVQgpzbJbppcxFLA7NqidA9FePezKH+3o2ksnvy+jpEoN9iqHKIA79r4dj5sh7o6vmQXYw62hu96DBhdmDppGHALvB2uPmByBp7Eh0vYtigJGNns8557WtSYMT5XiwhB6Q1PHj4iQq1cEeeneSvXPMbUXy8lLvChsQ1Xw9NQBU3m4Ar8Vm0uNhaicD3XweRyIOXQWF/ZL7zJRHfT+YSOV6OfMEk3GY67Goxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LlMxP/23UWCa+zmRybeb9+odgu6NsLad5hWpGnVY4eg=;
 b=nuSNSkqmzdwOFu3r1YgDr+IpmXvK266fkHyprqkBS3GaKTXsmMhaavHkxW4CADrHi7dPMk/vzvF/gOWqPIozndkGmJIa3qLqOhfn9RC1oye6oi6Y88n6q0rLgHr47VcXwrfGCgLrdEwLxFRnRLbdF6bJpAWWChTVXIxwphvFZhE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 LV5PR12MB9779.namprd12.prod.outlook.com (2603:10b6:408:301::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.25; Fri, 11 Jul
 2025 08:07:56 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%4]) with mapi id 15.20.8880.023; Fri, 11 Jul 2025
 08:07:56 +0000
Message-ID: <fda6f75f-2fa5-444e-9b5c-f4788e29a88d@amd.com>
Date: Fri, 11 Jul 2025 13:37:50 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drm/amdgpu: refine eeprom data check
To: ganglxie <ganglxie@amd.com>, amd-gfx@lists.freedesktop.org
Cc: tao.zhou1@amd.com
References: <20250711075958.27835-1-ganglxie@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20250711075958.27835-1-ganglxie@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BM1P287CA0018.INDP287.PROD.OUTLOOK.COM
 (2603:1096:b00:40::22) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|LV5PR12MB9779:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e05a074-3814-416e-4a7b-08ddc0520ad4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?V1hUbjFUWW5zUnBrdm1EelNpaW9ucmxUYXYvMFNCdFRaRjBSTzVTRUMwVk1G?=
 =?utf-8?B?UXBXS2ZZcHFQaE1ZUFBzNUNLNUFEa2FLZkdBWi9ZYUlkK1NiYWc5ZXJtKytt?=
 =?utf-8?B?SHVHMW5qK0R1NncxcHJUOG1GUjMzMEtXcmtUbXFtTlRZQlNoVVg0Y2Uwd3BE?=
 =?utf-8?B?aWNCMWRObS8rMjgrYStHcHJWK2twR00yOTJUMGM0ejhQQVQwTDZ5VGxydlZ1?=
 =?utf-8?B?TkdsU09TYnp3K0dyUUhtTWNOcGsvdU5oeVNuU01jRTY1MVJVcGswYzVBZWZX?=
 =?utf-8?B?NGdUNnZ6elF6NjhqTzEvelFPZzZCM0l1dys1b1hRL2FkMGtkblJTY29lZGVQ?=
 =?utf-8?B?Z0ZuYzhUdDlSaXU2cU0wUTFOTFMzM0tFcWdsSmlvVG9XVVhZTytVU0ZNS0Jn?=
 =?utf-8?B?MVExbVNzUURXUXVQZ2s0eE1iR3dxSHh0WW4vZ1BzU2ZGaE13dFI2aDdEMDZp?=
 =?utf-8?B?TEd2NW43UnJjSG9hOTkraytITkhScmp4ZUVjZ0dEODRwMElBMlc5Qk83ZmRa?=
 =?utf-8?B?SnlaV000S3l2RytXUEF5d0dsY1ZkamxCdlB3cTluL0ZlQ1gwTG9QZjFIYVhP?=
 =?utf-8?B?bk93ell2VWFHZTBpaS9nd3diMWQzcTF3dkpmNUxVRVpTWWxlWDM3RGpGaGRp?=
 =?utf-8?B?dU9YZk1HME1xd25KSEhoSGM3S0xBTGc4cXZrZEhCSFkvTVA1SDA4YzFHMHpZ?=
 =?utf-8?B?Zngza0hLTm9UQWxQVW9ENktDMzB4ejN1bUxIM05iQnI2NnRJWExYd3JRVjh2?=
 =?utf-8?B?MjRnclM1RGJvRUJQVGNNNkp2dURidkVpdnlQVlgrbkh6NjhXWnQxZWF5NlE5?=
 =?utf-8?B?djU4VjQ5Qys4Y2srV1o3R0xiOG1ubzR2S0VaOEpRUnAybFF4M2lBV1hOSWhB?=
 =?utf-8?B?Y1d0NEpScWVzb2Z3VVpML1ZzSXlSRkdRL3NsRnF6SmVETFFmY3h5TnV5VC9B?=
 =?utf-8?B?K2puaWsrZlN1ZExMTVNHWjQ2d1l4cStxU2pmNW0rSCtQMGlRblJESWVYUGxM?=
 =?utf-8?B?RmhEa0ltam1Xc1dWd1h2MWlKbVJaN3JmamZORmlrV3MvVDdnSk9JbHJPdDJz?=
 =?utf-8?B?a21aeWprSnM4Y3hsdk9URC9VUVYwSDdVUjBLdHg3bUZ4WVVuaEdncTk2aFh5?=
 =?utf-8?B?SU83R1ludXpxbnBVNE84bGVRc1Q0WkRqaGJkTXN3dkxFTlhmaUJNOWpwSWEw?=
 =?utf-8?B?UytqYnAzN3VVQkkwNjZWUG1UUmpQOFJhLzVwVzBHbDg2eVJpZFN2N1E4VVJV?=
 =?utf-8?B?dDdnQWt6WUE3bjd3cFJ4bGVWZ0M1Rnp0SFp2VUVkRERlSitXWFFvTDJtb21p?=
 =?utf-8?B?WmtIdVgwTEY2NjBDMWdpTml2QTJ6VVpoWkY0aXdOemJuWHVvaWkwN0NpbzhY?=
 =?utf-8?B?LyttWWduMlJiUUZ2RWx3eTRCZWdPeHhwbTJ1ZGtXUUw5MzZIQmhMa3dmMk1L?=
 =?utf-8?B?eTRZcXlWUmJGV0w1QlF0NWxpaElZR0oyK1ZVdlpzRU9mWUFaTXhFTnZoNTZr?=
 =?utf-8?B?SCsva2xmTFFwdkI1MW1mZjVCa1pHbDF0MEM2VzdQc2JyOEZjUThFRjFVVW1W?=
 =?utf-8?B?eDJGMnZDL0JKUEJtU3c0MUtSdnN1RFhrU1p3N0lCTm00WGZhMlFtYURNb3RP?=
 =?utf-8?B?Sm1nSzFnVEI5VUJwMDIvUU9PTlJXQkZGbWkvYmVXRmI4TUNWVEpHSC8rbVlm?=
 =?utf-8?B?eE9qRGp6blVMOGlGU3F5QWhQT3QyOUdUODhhY2E3ZWJXeStYZ2thMnpCVFBi?=
 =?utf-8?B?SEVob2prRzVnd2x2VVQrYWNxNTdJYk44WnVZV1pHQm1oZVpJUHlOeVZKTy9Y?=
 =?utf-8?B?UHZmc2ZYRTl2NVg5cUdGU0FlM3pNbXBuNUNKL0g5MCtSK2ZTZHo1Qm43RE9B?=
 =?utf-8?B?TG13bFdzQjF0TGpJVmREa3FiMFYvRkdFSVFsY1B5T0o3a1BGMVE5bHByciti?=
 =?utf-8?Q?nUKgI75Txwc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SVlWSnBHU0N3aC93RGlqMk5aY3NnTzZsOXl5YU1zU0o3b1Bza0liT2g1Z0hv?=
 =?utf-8?B?ZGJOT1YyVDIyK0pScG9MVVZ2UXJ1TmdER2pkK3hUbXZsVmhPZnlRR1hkTlU1?=
 =?utf-8?B?ODhPSVExYzFQSjVYTU1oNFZLbFRnQm5qZFN1V2RIdThTc1JHZVE5c0h2SkIz?=
 =?utf-8?B?bUhZZXFsVWpVQnRRVjlSZjdoRktJcmJDODZjMVUzaFArZ0M5cFVNSGhxWko4?=
 =?utf-8?B?dFoxNHhGbUdpS01WMC9wZmd5VFg5ZlVsMWl3cFQxUUtwd0hTRDA0Y3J0Z1Fa?=
 =?utf-8?B?YlJiczZ2MXl4bTgzbFhqeVo3Qm9MNks4TUlnb090MlN6ZzVXaGNGUWtWekFN?=
 =?utf-8?B?THdDeUNlK0pKL1BMU05iN2R5UENJNzdzdlVFM1l2MW8rSHczZUFHTnRJa0Np?=
 =?utf-8?B?eVAweVFXMXh6dGlraldGMFhkTWovQ0FpbmlqNWRvWEplNHBKcVhIZFYwY21O?=
 =?utf-8?B?dTc0VGV5K1c1Nk9qbGliL1ovYUE1YUJTYjFWQTUzejF5WnFhaHF2SkNjNDFF?=
 =?utf-8?B?dXpoYWpHZVNrbktBM2g4d0pOTmprbmJpT05mYlFwUjh1SGdZQ2dqNWNQZGpa?=
 =?utf-8?B?Y2FNOG9ZYkhDc1h1bjkwVnp1MzRNMW00Q2Z3Uk56Q3dCKzZ5Y3E0Nzh5cGJv?=
 =?utf-8?B?cFo0WkVVZ0d0ZXgyWVFvUWtORG5CVTNMenpXTFlaMWRjUmluZS8wUUxnUjZO?=
 =?utf-8?B?MWdxTURlU01US3AvWUF4elFrRFpTNHZoWjg5UThjZkt6aGVRVENLcllsaGZB?=
 =?utf-8?B?eWY2NDNjVXpxNWpTckVlVGdSTDA2V09WT2ZweVcrZnNyWERoRUdJa0c3aWJH?=
 =?utf-8?B?NWswWDNQK1E1aVljY1F5cDR2NEFlb0wybnNJQ1VscTBwcW5vNnI1VndRV2lk?=
 =?utf-8?B?TVpldTFhVWxnUVJSTzdWbHh3TFJKdW9hNnQ5cEozRklxMEFSNHNMajVNMkdP?=
 =?utf-8?B?UHpmSktzcStpcmQyYzB4STk4enYxcW9pV2VYQUlCRCs5MHlqY2pkOEZIMFhV?=
 =?utf-8?B?QWVqTEJOWGw4ZmxocTQ4aHJkaEJYV2pEL0FySkRkcTBWeDA4bWdSQVBCY1lN?=
 =?utf-8?B?aUg5QXhwZDJFY2FjL2lnN2RxV0VMVWJwNllrcGw3dmE0ZXU0d2lTNmhMQlBo?=
 =?utf-8?B?eGNwaXRRZWlxNlptejV4UWNyclFyN1BHdVY0c0daZXhQNEdTZWduRXZsWUJv?=
 =?utf-8?B?TFVsZUdCTGFkTlAzM0d3SjYrZk1YSkcrWVNTUklKNmdZaUdiY280NGh6eDVC?=
 =?utf-8?B?Q3NNVDY3R2tDTlZ1MWl1V0VxOFBXcThjcVdGSjJYYTVTYWo2VHVJbkllblZu?=
 =?utf-8?B?NmNZVUU1WGtQTWMrZjBiMDhIdWxZaHkyT25jU2g1dDdzSmg5RStJVEcxaVFW?=
 =?utf-8?B?dUtHNmhGaUJxWTllcGJLL00vMGRvcFp5Q3hkdXNyQkwrZExkVURqZno3Q0Ey?=
 =?utf-8?B?WUhjOVRabDRZb3JPdHUwZWIxaUp1WkttOEo5bElpT0h6aStmQzRJY3hDZFVR?=
 =?utf-8?B?eC9qWGoyeWZwRVlEWjU0aUo4VnkrNFJ4bmFYc1U0cHp5SFZ1emJibE9Fd1dU?=
 =?utf-8?B?M1dXdmVLVVBPZnAyVEJPTm9zd1ZHZGFXU21OdnptNzgrVkg2aXlmMkJnQXgy?=
 =?utf-8?B?VDR1UTJPS3dEM2VHVC9JeHBORldZSXNPYkhOR3g2ejJPVlVZbDQ2VHIxR0Fh?=
 =?utf-8?B?ckx3SUZpa0Y5SzJUSE04dFpnU1Z6TDJhTXNPNERhWXBZOTM5ZGZFT0xmZTRE?=
 =?utf-8?B?bzBkRzJtVnVUb3U3cWVVUU5sMm5UalplWjVMN2lLTml6dDJsaStHQWVueFZm?=
 =?utf-8?B?cEVmOGlkbmdiNDlramxqemJodlR6a0ZGQU5FWmlEMzkzLzExYzRVTHFKcUZQ?=
 =?utf-8?B?a2pMd04xUUhrM0JUdTdZc3V5TU1mcmJmUnVobFJMa1g2TkRWUTRhZlJEaGVo?=
 =?utf-8?B?OU13d0R3NTh4ejRFVjcrakhJUGswOElQZ3VhR0VlMit6allVdHg0M201ekNE?=
 =?utf-8?B?cE5pK1BvN2FxYkRwZ2ZFUmJ4dGxNT1ZYU0Z4RFNsNzhVbWQ5VGU5L2J1eHho?=
 =?utf-8?B?U3RlMlMxN2hheEU4dEo5bjB0M2JWNmVZS1hseGxHeFN4aThlV3JYOGVCWVNz?=
 =?utf-8?Q?2I/7VonDab49dBzFNEjPnKwsa?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e05a074-3814-416e-4a7b-08ddc0520ad4
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2025 08:07:56.3731 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tnGhm/HkMAJuPdzxH3DUD5AuxUyFA4PwD9CFX1owLWmUahtHQcGyF2EJHVKi9umM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV5PR12MB9779
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



On 7/11/2025 1:29 PM, ganglxie wrote:
> add eeprom data checksum check before driver unload. reset eeprom
> and save correct data to eeprom when check failed
> 
> Signed-off-by: ganglxie <ganglxie@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |  1 +
>  .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c    | 28 +++++++++++++++++++
>  .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h    |  2 ++
>  3 files changed, 31 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index 571b70da4562..1009b60f6ae4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -2560,6 +2560,7 @@ amdgpu_pci_remove(struct pci_dev *pdev)
>  	struct drm_device *dev = pci_get_drvdata(pdev);
>  	struct amdgpu_device *adev = drm_to_adev(dev);
>  
> +	amdgpu_ras_eeprom_check_and_recover(adev);
>  	amdgpu_xcp_dev_unplug(adev);
>  	amdgpu_gmc_prepare_nps_mode_change(adev);
>  	drm_dev_unplug(dev);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> index 2af14c369bb9..df0e9b87d578 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> @@ -1522,3 +1522,31 @@ int amdgpu_ras_eeprom_check(struct amdgpu_ras_eeprom_control *control)
>  
>  	return res < 0 ? res : 0;
>  }
> +
> +void amdgpu_ras_eeprom_check_and_recover(struct amdgpu_device *adev)
> +{
> +	struct amdgpu_ras *ras = amdgpu_ras_get_context(adev);
> +	struct amdgpu_ras_eeprom_control *control;
> +	int res = 0;

This initialization could be skipped. With that -

	Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo
> +
> +	if (!ras)
> +		return;
> +	control = &ras->eeprom_control;
> +	if (!control->is_eeprom_valid)
> +		return;
> +	res = __verify_ras_table_checksum(control);
> +	if (res) {
> +		dev_warn(adev->dev,
> +			"RAS table incorrect checksum or error:%d, try to recover\n",
> +			res);
> +		if (!amdgpu_ras_eeprom_reset_table(control))
> +			if (!amdgpu_ras_save_bad_pages(adev, NULL))
> +				if (!__verify_ras_table_checksum(control)) {
> +					dev_info(adev->dev, "RAS table recovery succeed\n");
> +					return;
> +				}
> +		dev_err(adev->dev, "RAS table recovery failed\n");
> +		control->is_eeprom_valid = false;
> +	}
> +	return;
> +}
> \ No newline at end of file
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
> index 35c69ac3dbeb..ebfca4cb5688 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
> @@ -161,6 +161,8 @@ void amdgpu_ras_debugfs_set_ret_size(struct amdgpu_ras_eeprom_control *control);
>  
>  int amdgpu_ras_eeprom_check(struct amdgpu_ras_eeprom_control *control);
>  
> +void amdgpu_ras_eeprom_check_and_recover(struct amdgpu_device *adev);
> +
>  extern const struct file_operations amdgpu_ras_debugfs_eeprom_size_ops;
>  extern const struct file_operations amdgpu_ras_debugfs_eeprom_table_ops;
>  

