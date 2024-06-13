Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D45CC27C75
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Jun 2024 08:06:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CD86010E98B;
	Thu, 13 Jun 2024 08:06:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="eZ84rcVm";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2062.outbound.protection.outlook.com [40.107.93.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B080510E990
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Jun 2024 08:06:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N22ksXh/uFnAzm7lTDJZdvKRoX/L/WUF0ItRzy/eo4VN134ZyJUfq1E7wEiHbTMB6NqQJ1QjGhSCyZAMnv+l/OjW8eUg60tjlY3ZjQjCm+X2BE0h9Ao6OQkPibLDFQdZaYsU1gSFK1/cL0VKbk2a4qaF09K/Owk6z3ccSdCFLr05vjybrplU+7KG6p79a6e6EjVntKnkkZE7jr5nSjYc+GLpcbB3zXX+lU2f6ymbIJKJbBM7xHtPPeTL4ljF+L2JJI000bvyWyPCR10Vb6iQbaPc0aMfEFcGC4HwjtKzVVah3Qkhv2wEwQ98WnTkLNC2TYIOy2oa+kqujiMQ9NrgHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8LiLibR2tCWmq09bQDlLBYqVskuxjCvAlQ4S2uIXlwk=;
 b=Z2i7Pgl0407aWQ9RmdJJ9QzG/uTmxa1Slr8CjQ0Nf/4y9ArYH+uhgrKQ6jMALQhobD9dpBi34qjGGI/jc3roB2GkoyTZ1/aK8R51HalE+Sl1FijomAbs5zJXyxqczbS/e0pWwX9TdMK+RQQQS1KLKIUG4nuwzFfnrEG0I/52LVB6nMfb4HN0L/wlq3f65VxVGQH/PWmZ+0JPEf88rZrQCeYeYu7Tc1AcWg3afr24XGQfArhgPoferFpfhv/AF9UeACO/MNj+u30JyfqaONjlbZldJv6/GadbBuaA+CPh9Pv/cJlkQ4MFgyT9Oj20eYLF0CDvHcjC6UrFxjb5mbgg3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8LiLibR2tCWmq09bQDlLBYqVskuxjCvAlQ4S2uIXlwk=;
 b=eZ84rcVm218YoN0D0/Gp7A41jNktiW7PgMj52EtZ4IcRm5XTkJix+9p/KE9l3/W/U/C2Nv6F1GptdHeYzshpeCncnU0s+jAMuG+pu9S4it398/q789G5gEaKCahndI50TUDXbIP4ynf7q+1JB4Fh+eui3FKS20epFGb/rvtpTg8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 DM6PR12MB4355.namprd12.prod.outlook.com (2603:10b6:5:2a3::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.21; Thu, 13 Jun 2024 08:06:46 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%5]) with mapi id 15.20.7677.021; Thu, 13 Jun 2024
 08:06:45 +0000
Message-ID: <cc2e1263-d8e5-479e-b5fc-38d09ec200ed@amd.com>
Date: Thu, 13 Jun 2024 13:36:35 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: use mode1 reset for RAS poison consumption
To: Tao Zhou <tao.zhou1@amd.com>, amd-gfx@lists.freedesktop.org
References: <20240613065726.30129-1-tao.zhou1@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20240613065726.30129-1-tao.zhou1@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0132.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:6::17) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|DM6PR12MB4355:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ea373ce-aee5-4f9a-76ef-08dc8b7fc468
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230034|376008|1800799018|366010;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?M2pGREhsSDVBNGdITDc2ZnMxbEd1ckRMdCtyYjVtb0tacEZHeHk4UEUwZWcx?=
 =?utf-8?B?OWlLaTRBbE5TYmNjTTY4Y2JhRXk2dkFaYUN0eHlEM0RaYVl5S1dvbEtrT2RY?=
 =?utf-8?B?Umoxd2ZDakNkREtVRzZhd3A0S1lFVkpYeGZuM0hqKzY5OFlNRU1kbjI4aCtL?=
 =?utf-8?B?OTNYNWd4Q2t1Y3c0c3ZUTlhjeFNOYjlCK0dsK2FDbzdCZEJDYUdYTWdhYmh3?=
 =?utf-8?B?TWVXL28zaXB5L3lnOHRxOWhpYytPY1Z1bUtYRjRtTGFFVVBBd3BsTGtLc0o4?=
 =?utf-8?B?dk10NnJmYVdxeUpuMisrZVNGbUNXYndPZFFSVzZGb3UwOXZQQ0hzT3FGVVZF?=
 =?utf-8?B?eEMxRThWWHpYWkM2T0hXSDVES3pWdjhMOUQ4Y3oxWTZUbk5VMTN0WXp4Um15?=
 =?utf-8?B?N2ZmMEQrTEF6L3FvVmxTOFlCK1Q0SHkyNzRYMEJ4djFidTBMbnFuTTBFUnQ0?=
 =?utf-8?B?dGUwRWZYY1NSaUJ5YkhJQngvUmNFbjJadjVMTGlraXN1c1NVVW1BQ3hMT3Zr?=
 =?utf-8?B?aHpacGpReHNDZE1YMVd2RVpsNit3ZG1tS2NsemhnRGxzbDdRRWQvZzcwR2ZP?=
 =?utf-8?B?T0FYS0xtMGd2Vlp6RkYxK2laRERPb2wwUG5rR2xXd2hPWGJ0VXFIRnNCdCtE?=
 =?utf-8?B?VU5iQWJxaFhTejNJRG9xNFVqMUVOd2xuZWEwUmhlSjhqZFgxVENRaVRXa0Q5?=
 =?utf-8?B?SGxLcGw3Z0owMDNLQVBscFQ4bWNnSkxoYmVndnFRMjhTMHFZeXdZK1ZETDNF?=
 =?utf-8?B?Rmw3U3cwN2tOWkFJeEpZRlB3aXV4cUFOditIMk1Cb2xVcDdhQ0xsWXFjZlAx?=
 =?utf-8?B?OVNLSVZ1bWhmQ0dabnZnSTZwMVhwTEx2RWcxT29jQ0l5YmRCQncza3J3elNG?=
 =?utf-8?B?MkRvZGN4Z1VpSTNoK0dlNHh5YWNuQlBIMEhqVnlkSGhxZTFYNWNzTXUxWGov?=
 =?utf-8?B?Ynd1TU82ZVY5MWc1eEdxNTZRNXcrd3BrN3dKK1hDZlhXcWY0RlRjR1ZoT3Na?=
 =?utf-8?B?bE95SW1jcGVZdEl6azR5dG9OcUszMWw2M0l0MTh0YW16R2I5K2F4ZUdyd1Mr?=
 =?utf-8?B?UWNzdGdPSWN5SHNabTFPcTBIbkxQNmx2UENVY3BTV284blNCWmNLU2xQcDVV?=
 =?utf-8?B?ME0zcUZXb1ZFTXRUdkIrRVFuQVNkRHJRMlFML0IyZmRGUThFT2lDSHRwYVQ3?=
 =?utf-8?B?Skd6Z1pOWTN2Vnc5ZTMwWGZqa1B0c2QyNlovQklLajllYnZUeityYWpYNTRq?=
 =?utf-8?B?anVwdUJOSkhiNlp3QjFLSEVXa3dXVEVtREtsUlBZQjlybEhEbkF3U1NZYWNU?=
 =?utf-8?B?N2lwWDgwbXVoMnBtOElpbVRmUUlpckx6c0VzNkFCZDAvZzk4YlpxYlkrVXpC?=
 =?utf-8?B?eFpFZnFRenRzNXdFOVQ2TzI0SExjR3Y2Sm5LNU5LWFhhaXFPcnpmc3BzOXQ1?=
 =?utf-8?B?S0VkTXJPakw1MkNJTjJGYlBvVU00S2pjNlRZRnpRMnNUSXI4Wm9NK25OYkg3?=
 =?utf-8?B?NThkeU1kcGIyK1NrWDlKQm52ZmxKcnJKc3dadTBxbDdESU1XaVZkMkVRWWV1?=
 =?utf-8?B?bzhMUGNUakpXT3ZkT3ZZYkd6a2dkNEJHTHRKc0RJRDEyVXpLQWsvUjkrNzdF?=
 =?utf-8?B?cHhmblNGUlZEVTNlYjVGR1lEY2REWTNWdk1QMm1qclFjR1hrd3RjZURPeE5k?=
 =?utf-8?B?cTZmTXdBS3BEd1FhcFdSR1R0QnNSdFlieTI3Z2t0OGNBQlJrNmhGekFHTytS?=
 =?utf-8?Q?7O11lsvFRgdjuEMhkuAbIhY/nzn4+MZjHRGgvWv?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230034)(376008)(1800799018)(366010); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M0kzM0ZwUU1NamhBZHBwczdPalhHUFQrTXYyR0EyU28rb2FkdWdoMlNHcE91?=
 =?utf-8?B?Ykp5U2RNSUhXNW83dDgrQ01QL2t2SUJZRlY5djNGSGFZeDFlcHNGdTd3QXBL?=
 =?utf-8?B?K1UyRGRxbHNNbnVmOWhLREFDVi9vN0FLeXlpVllrRnpzYVZuM3N2aFdqcXdL?=
 =?utf-8?B?VXJQYVAvUEJ5b0ZTM25hM0ZvU3pBRUVqekM0RGhSZUdNSFZFd2pqU1RCbit1?=
 =?utf-8?B?V2NmT3l6bUZWZnIrMjMxNUNwa0hyYXVxYVJEcW03ajJPYTl0U3NVdTUxM3Fv?=
 =?utf-8?B?ZVhjOHJDNW9nSnY4azV6MjNoV05MRUgyTExKNHY0dG82Vkh0K29WUW9tczhB?=
 =?utf-8?B?VE1YSERtTTdiSFovYjE4dVBLZW9EemNSK1JSaXJjdkc1NGFlczJ4TVh1OVVm?=
 =?utf-8?B?N1NFYVp6blJtZ1VzcWhlY1FMcnFDWFNZTzJ2WVpSUDJwV1FqSDhid1lkUUhZ?=
 =?utf-8?B?N2tQbG43UTVvdzZOWmVSZnZiSzR5SDYzeG5xVVY0Qk1CTm9FQ1hoUkUvQnlI?=
 =?utf-8?B?bmZTM1QyQW1jWkUrUm4xc3pYaHdtMzN5emYzVlVlRk1KTHdZcjVxbnV2NFI5?=
 =?utf-8?B?YlpRdzNpRG9Bc3lsVVFUQVJ4WnRGbjd5OFFNNlAzZlBOTU9DeFE0TE1SWWVz?=
 =?utf-8?B?WTVyblZmQ0lYUGt2MG5USERtZm82TTQ0TEVoWWtGVjFVY2lCY1NLVnJ6aW5s?=
 =?utf-8?B?QkZnYkFtWDdzS20rUHlFUUgzeU5MbFdFMzVXTkw0RzZSZEFSNnhwV0huZ2I5?=
 =?utf-8?B?bVFwYlUrRUJ0QlNQMW5qK3lhMm1yS3pxdldYUHpROTFVV2FkYzF5U2ZBelVs?=
 =?utf-8?B?R1JIWmNObGVrU0ZXdkF2R3k5MzQ4VTRGLzhNbkgzM2xPSWk3Ri8xSFB6VUtv?=
 =?utf-8?B?UGRvQ1FMUVZrb0lleW5sb3o1YXE2NFlsamxKRXFZbGMrbi9YUURLQUowMW1M?=
 =?utf-8?B?cHZOYklLNkxzcVBrV2xiTE9jOXBLTSt3N2ZUdHN5RHE2WVNsbnZpYzFOL0JS?=
 =?utf-8?B?ZnRWUnhNQUJtblEzaEo2R1l1RkFzVGhyWmNzOGZDRFdrR2pZaXhTN3BHVkRY?=
 =?utf-8?B?OTQxRWFicGhiU3lLdER4NTNZSGVZWjB4eHVmb3EvdytnQzJmcmorWHBXVW9o?=
 =?utf-8?B?NmY3dWtaUnlnYUNYcFFuVnduRlp5VGUrTEFNZnIrdUFDRnV4Zk9xd0RhQm5J?=
 =?utf-8?B?M091eHJoTmM2T1dEN2RmaHJMb0l6dy94OERYYktRS3lCN0ZvMzFsT2prQ2J1?=
 =?utf-8?B?a1V5dTBHbkdWczRMcmZiUjhZSlpPbTJZa1lTbnE0VDhKcmphdDhUZE1kNUFY?=
 =?utf-8?B?d04wY0NIRVAvZVdqT3RmU2w0SmZHTEpTR2ROZ2YxbUVtRXVKbTVTOXZMenRs?=
 =?utf-8?B?WExRSU9ZY3hUZm5oUEszRXFLZFZXUUZKNUZ5cFpDd3RiVjUzSFBiS0QwRnFO?=
 =?utf-8?B?UGtZazJYT1JybDBvTmFqR3hyN0ExYm1HRURWOU51d1U4TkJ0MFhlYVBUbzN1?=
 =?utf-8?B?ZWFYMElFencxQ1hTUll0d2NvRkNxKy9FN1Y5R0Vmb28ycjBtendaOG8vaXJk?=
 =?utf-8?B?WnVNUm5Pd0dUaVBFeC9QNFFRa3FId0RxVXA2ZG5ZaStYMlI4VE1IWVFpY0E2?=
 =?utf-8?B?R0trbUVxbldaRklLNFZialdYUEY1ZDl0TUdxTVNMQ0NJc056MnQ1UGNCWFpj?=
 =?utf-8?B?SFd0b0h2UXJmLzZ2MGtCZmczN29zNlhCekV0cmpCM25nalRPVGFZb3dXVkxC?=
 =?utf-8?B?TnBJVS9EYmFoRXFIeVNtOGF4NjRvSlJtUmVTanRnMjUvaTlLaDBreHhsVUVl?=
 =?utf-8?B?ZVBUQVg1d0NnUDhEaE1PRG5URG9yRDZFc0ppVEVCWmhNR3QwUWhPbW45cGVp?=
 =?utf-8?B?YmdtTjgvUSsyYnU5RXZTUHZZWlFrVVJ6RVRDN0F0WC9aaEgySEJ4WEgxdk1E?=
 =?utf-8?B?ZDFTTFU0VmhBU2dhR01BUGZHbks3a1BwbDZGZmtkOXcvQ1Y2eHZLQ2Mwdm9k?=
 =?utf-8?B?YWFUV2kxMUM5TExSTHc2TnFEZ0IxNFRZVnp1OTEyTko0SmNSTmtIUk9SRy84?=
 =?utf-8?B?V3RJRS9MZEd6NXkvVGhRYnBKVGZENWsvZW9oc0dXeERldXM3Nm9mMHJDdDZm?=
 =?utf-8?Q?SeyXjl87xSXfnsfsTo+16JYiq?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ea373ce-aee5-4f9a-76ef-08dc8b7fc468
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2024 08:06:45.5611 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qn0RSOLuCE8SGzUyeXCv9KKSjamCwMm6hCvhR+AdrePgSl+1AW9qsEw9TN75kWpI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4355
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



On 6/13/2024 12:27 PM, Tao Zhou wrote:
> Per FW requirement, replace mode2 with mode1.
> 
> Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
> index e1c21d250611..78dde62fb04a 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
> @@ -164,7 +164,7 @@ static void event_interrupt_poison_consumption_v9(struct kfd_node *dev,
>  	case SOC15_IH_CLIENTID_SE3SH:
>  	case SOC15_IH_CLIENTID_UTCL2:
>  		block = AMDGPU_RAS_BLOCK__GFX;
> -		reset = AMDGPU_RAS_GPU_RESET_MODE2_RESET;
> +		reset = AMDGPU_RAS_GPU_RESET_MODE1_RESET;
>  		break;
>  	case SOC15_IH_CLIENTID_VMC:
>  	case SOC15_IH_CLIENTID_VMC1:
> @@ -177,7 +177,7 @@ static void event_interrupt_poison_consumption_v9(struct kfd_node *dev,
>  	case SOC15_IH_CLIENTID_SDMA3:
>  	case SOC15_IH_CLIENTID_SDMA4:
>  		block = AMDGPU_RAS_BLOCK__SDMA;
> -		reset = AMDGPU_RAS_GPU_RESET_MODE2_RESET;
> +		reset = AMDGPU_RAS_GPU_RESET_MODE1_RESET;
>  		break;

Does this need 9.4.3 IP version check?

Thanks,
Lijo
>  	default:
>  		dev_warn(dev->adev->dev,
