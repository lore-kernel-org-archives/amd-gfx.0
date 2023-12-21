Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7D62C35274
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Dec 2023 16:53:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BCF7410E0E5;
	Thu, 21 Dec 2023 16:53:40 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2050.outbound.protection.outlook.com [40.107.101.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E621D10E0E5
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Dec 2023 16:53:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZcrTmp946aJ9TTBjY5D5vzHEO2Tm6SvPcKwb3lagW3r9FW2fYbdcqqII39eCc2dEMKMJuyy77SQQAl92yJzJqAnU5AI7mCR7gUnop88TAhwvc9DaWRpX+e8B1O5Krl6IT3e7LkAAdxby886fpPnjc5FEuiMAjyX+Yef/Ptgayf3cM4EalalV9syraJ41lkxtnwTtIuZ7wKjSev3NnmeuGXVGgHLRXjG4loAY+H22FWTdK+11c8DH29slNP7iaLVUXi+Xarzd9guWDGcOnrKNR9Vd5ZyXKrod+8dNlWSF7MrxyDApKoCpIZxdtMvwAO6B6b0mZz7YBKKg7uUU1LMnLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=unRllx70+ilzyCcMhfem6uD2vuYNVOh3OI2eV4IFvAA=;
 b=j+Ye+ajVw6VhenP00dHWfB3DeVCGUY3i34YFN3qmOeWfUlgPrUfbQg3R01Kla/gWcw6cNtADUw5xThIgerPIGN4vISUa5TrH1euPKo3WRxoGtYbnxBpGOqwECHveUXmvND1IJcVDCVSMRbb6dNQFbWvUaEGhNteLp4Ja0QOCGlHRaZZePAQUq+FATNgAl6u83yQnkS13Qqh+EnEC0MwWRzK0iLj8glD9r8o9pUg/pADc+iR31lJAXrBcVvD1g7T2ICa0RoQ2IOmJGb7seWtjGLsljpgOowsxLQSJKjWU6KP6TVD9/DgzteG3DW+FSB9x6xXRLLbMDbKvIMd30TaiJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=unRllx70+ilzyCcMhfem6uD2vuYNVOh3OI2eV4IFvAA=;
 b=ymlD59hSTbzeVTYrCHX+yX5H26HRdHaCT/F39dPUFg8KXP7QVyffEmAkQDXoy/uBmUcqxOnIDY1TRohqBX7VxJ8RXeeTeEbMu65BD093eeqS6oY9GQjan92izKIOa1wKoBDUctZaJtBqM8ys1Ou8vVqb1TOgXnRyXwCC95AT+YE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB2941.namprd12.prod.outlook.com (2603:10b6:208:a9::12)
 by IA1PR12MB6283.namprd12.prod.outlook.com (2603:10b6:208:3e5::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.20; Thu, 21 Dec
 2023 16:53:37 +0000
Received: from MN2PR12MB2941.namprd12.prod.outlook.com
 ([fe80::5f1e:bfb0:43e5:dc81]) by MN2PR12MB2941.namprd12.prod.outlook.com
 ([fe80::5f1e:bfb0:43e5:dc81%2]) with mapi id 15.20.7113.019; Thu, 21 Dec 2023
 16:53:37 +0000
Message-ID: <15ebcc6f-7c87-4be5-88d7-d44f7f6713f8@amd.com>
Date: Thu, 21 Dec 2023 09:53:34 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: Adjust kdoc for
 'dcn35_hw_block_power_down' & 'dcn35_hw_block_power_up'
Content-Language: en-US
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
References: <20231219073734.149142-1-srinivasan.shanmugam@amd.com>
From: Rodrigo Siqueira Jordao <Rodrigo.Siqueira@amd.com>
In-Reply-To: <20231219073734.149142-1-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9PR03CA0520.namprd03.prod.outlook.com
 (2603:10b6:408:131::15) To MN2PR12MB2941.namprd12.prod.outlook.com
 (2603:10b6:208:a9::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB2941:EE_|IA1PR12MB6283:EE_
X-MS-Office365-Filtering-Correlation-Id: 86635b1d-3c9b-4f2d-be13-08dc02456090
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HhgtR7X2KAuLk2XY8fp+QFI+cYbP9n/i6kyA6lWH2nSDFWN4fCQEDPinj0yLUP/+NBcBaR2x8z2pw6sojJmJmXyTPMn99duDkitAMlxqEYKXPyFmdSMEHaNRkpJULcwk+xpoqKOtJCW1l3q0uz22vb5/s0KcYkNSQYpyzGKaEi/HO/QJnDl/Gx3qthaA2nJjZwwN3JGqWzzLc9LwaAZmabQPTnHLhwluwoMpVH1wPF84M6kM2jBpbuzZNWXvcJ7k3u6KFk82OQhQR9z0FjGl4zCaeH/jYRbAZ7lbCXufC76G5of4A4D/z9agDQrV/++DEU5n3dBm27OZyjq66iWxWZHw4lvoOiWoO7OwOziEhSfqq18C/xNQxjYbbXD9oMd6EpACEIdTAuIcLB85U/5mYqntuL/ma2tgKx2+o9JkalCIq7DxUqGsvjE0VrELFU1d1qr/mr0jPvM3nlKBOSI2hsoQ5A1iljQStsVsA7x8oEj/30kHqbV/8Hu3FwPTZT8RsaKVmM/bB1oInjGOAU6wExXaAbJbNk9l0RmY0MBnYlGmTvZEohGjQ9pstUVQBhkqrZ183aoslNWM5tYVu8T89tAsc7/agu6Pje5XrNgyJHo9thLUGDNxQf8UX0iPyreRD+JW1xHLRQVneMyMGYolg6EDxcWjq799HjFHlbWdDmnxVM+QoA2+T1HOZmZq62vq
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB2941.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(39860400002)(376002)(366004)(346002)(396003)(230922051799003)(230173577357003)(230273577357003)(451199024)(186009)(1800799012)(64100799003)(6506007)(2906002)(6666004)(53546011)(31696002)(86362001)(36756003)(6512007)(478600001)(26005)(83380400001)(38100700002)(41300700001)(2616005)(5660300002)(6486002)(54906003)(110136005)(66476007)(66556008)(66946007)(31686004)(8936002)(8676002)(316002)(6636002)(4326008)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MjgxVmw3cWlocStPaFRsUFlXL3N3YnZIQkdnbG1VWjRMaEVzZEpkTDd3M3kx?=
 =?utf-8?B?UnBaNFNTWnZVSTM4aUhJaC9uMGIwZllCK3p5cDh4a2k0eG1iVE1HYjdma1Ja?=
 =?utf-8?B?Mi9icXdXK2FycUhRMEFHd3BjVlo0UGxDSTBRZzkzSitObzYvcGpyemhOTHp5?=
 =?utf-8?B?c3lBRjF2Sm1EMjZLSGk5eEJxdWp3OUlybVR5aUkxVUFUVElMS0daZ0RVZnFD?=
 =?utf-8?B?L1czWkREWEptR200ZmlQMnAzcUFzZm8vK0xrNUNXQ3hqaDhJeXhnNlZoUGlO?=
 =?utf-8?B?TFdnYzZhMHd2a2JtaG53cUhBTmtnRHJFejR1eFc4R2tFZkFMbkFINFhqUzdZ?=
 =?utf-8?B?WFFqd1B4cnoycHVoMHlZZXplRmdUdmwwQ2RuWE81WDJBTHl5WVlNNmdVQ3Zr?=
 =?utf-8?B?aGtISnVSZ1ZUVlhhL1l2c1pRZ1NwSTRkZVg5T2dWQldLRll3T0JieGEwc09W?=
 =?utf-8?B?dzUyQURjVW44R3NSTlRVZ2VtZ2drM0NEallJUDdkN21sUFg2NGVQNlhpQXpz?=
 =?utf-8?B?RE5WRnl1dkpSZmthUmExYkFSa1A1ZUZnZU1JYWhoZnorRk5hZzNLalJnMW13?=
 =?utf-8?B?T0wzTmRPM2I3ZmdML05KNkExQlBPOWpLeW9tcVNtbXBrazR4OExpVWFYWjZZ?=
 =?utf-8?B?SzZwRUZ1ZGMwUjBZZFJKYmJMekE4Y04rbUVZeXkvdUx4ZEVyZlE4K25UV0Z2?=
 =?utf-8?B?Q1VwUEllY1oxaWVFRFVPL2YzTktTQ09zdWEyaHFLelc5UW51M0tzT1lEdFVL?=
 =?utf-8?B?d2RoWTc2dTRoMkV5VjQwY0RYcmNXZWxQQUlFbEZMNUZTNFdQRXVRS2RCemM3?=
 =?utf-8?B?dnVUeVI1cjdFaElyaW40OUw1blM3M0ZjRm5JVGxIZ2VNRk5oMG4vWExSTyt6?=
 =?utf-8?B?WisxcGVNQllJSzkweWN3TjdHWmJFekNVOUdNRXYwSzNiMDBpV05ZSHQyN05r?=
 =?utf-8?B?dmxQSHBSZFRVbGFiWVk3ZE1RTURNUkdDNUNZWGR6djh2dTZiaUZ5Z0FqUCtN?=
 =?utf-8?B?UXNnN3VzcmRvY3MrMkE0MnBKbXJBb2hya1hPc1dQaTNmSm9VZWpNczZIYzB0?=
 =?utf-8?B?UWkvVVZpQkh4blV1Ym9SVU9mNjQzVlhzcG1lTGFTWnRFZFdPZmZnOHBpNmVR?=
 =?utf-8?B?Y3Q5VHErUDQrRmxwb3d3ZWFEREpPYnd1d1J6MVBlK1ZvakF2UFNnZ0hJN2Ux?=
 =?utf-8?B?K1ZMTHlQd1kvczRLeTZodE4xcG1JTnU5NHdQbE9Td1ZLL0N4SmNkV1JCQ2Mx?=
 =?utf-8?B?bFFYZ2cyWE5HdDlqU1NmZTBiRU9MV0JHc1ova3hYRTNqNEVXN0lvR3RMazJr?=
 =?utf-8?B?amw1eEhiYUFpakpINnR5UHJHVUM1YXY4SHRRaEI5c1lNT3lHcitFOCtxVGhX?=
 =?utf-8?B?QndCTlc4ajR3QjBHdWhJVmYxOHNEWDdYRUx1eEg0QWpKZDNZRmRsblpGWHJN?=
 =?utf-8?B?eEJjK0dyMmI2d2RWVjBrUlhEYW1UeHFhTm9CK1YvVUlUeDhRTzJ4WDM0UnBW?=
 =?utf-8?B?VmlHYmFIQldFV0RhTHltOW5kM1J4YnBGRzc3RXY0WnozdVJySWdaNDA2K3dC?=
 =?utf-8?B?K3dMQW4yaWVpNUNteXZTOTFiT3kvaXJON3JHU1JOVVJPQ3hvRHZ6VjBidkJU?=
 =?utf-8?B?NWoxcG5BVHVJZ3RhazJ3TVZWYVdRN01LNDcyOTEzOUFkR2MxVTJJVnJ5T2No?=
 =?utf-8?B?Z0VjelpvZEpqOWp6UCtxWnNrU3pxQTd5UVhqUk5rZzJ1RzNaYVVuUVVXc0g1?=
 =?utf-8?B?TlNSNjZSWkFMNm9XcGlPSFVPN3ZnWlBvWnQrT25JVzFtYnZ0UjYvb3ovTkEv?=
 =?utf-8?B?M2Q0QW93bjFvMXZ3M2RVanR6bWJwU0dvZmNkWkpnRHd6UFlJM2oxWU9OaU9C?=
 =?utf-8?B?RDFrcGVLSi83bytlK3hHa1MrYXlWM1lac0J3eDFoNjl3b0p2bHpKTVdJdHRI?=
 =?utf-8?B?dUc2T1VIK2N1eWxTRElOLzg5dUE4alhZVDlseXMyMFJIRGROZ2VXNVQrc3NB?=
 =?utf-8?B?YittVm9mSHZsbzBhRzlqZWxlbndmZzhaUTgwd2k2eHp4OXpBMkdnVW1oOHlQ?=
 =?utf-8?B?SG1kR05BVVlvdjZQMUJiNTd1QmZtRXNoM3cyQnhsenRaQU04T1VlS1M2SXJU?=
 =?utf-8?Q?JNW2wWflXbyG04ysSqrnne5oX?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86635b1d-3c9b-4f2d-be13-08dc02456090
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB2941.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Dec 2023 16:53:37.7512 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dP9DTEyuT8i1Gyny93kwUwUMqhoqAO5F7dxtT1JXRoOokoYMIxNmN/Ii4F1EYVLXkf9FVkcwnHXG2eR0B7cBlQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6283
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
Cc: Charlene Liu <charlene.liu@amd.com>, Muhammad Ahmed <ahmed.ahmed@amd.com>,
 Hamza Mahfooz <hamza.mahfooz@amd.com>, amd-gfx@lists.freedesktop.org,
 Srinath Rao <srinath.rao@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 12/19/23 00:37, Srinivasan Shanmugam wrote:
> Fixes the following gcc with W=1:
> 
> drivers/gpu/drm/amd/amdgpu/../display/dc/hwss/dcn35/dcn35_hwseq.c:1124: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
> 
> Cc: Charlene Liu <charlene.liu@amd.com>
> Cc: Muhammad Ahmed <ahmed.ahmed@amd.com>
> Cc: Hamza Mahfooz <hamza.mahfooz@amd.com>
> Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
> Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Srinath Rao <srinath.rao@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>   .../amd/display/dc/hwss/dcn35/dcn35_hwseq.c   | 66 +++++++++++--------
>   1 file changed, 39 insertions(+), 27 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
> index ad710b4036de..782c26faf276 100644
> --- a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
> +++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
> @@ -1120,21 +1120,27 @@ void dcn35_calc_blocks_to_ungate(struct dc *dc, struct dc_state *context,
>   		update_state->pg_res_update[PG_HPO] = true;
>   
>   }
> +
>   /**
> -	 * power down sequence
> -	 * ONO Region 3, DCPG 25: hpo - SKIPPED
> -	 * ONO Region 4, DCPG 0: dchubp0, dpp0
> -	 * ONO Region 6, DCPG 1: dchubp1, dpp1
> -	 * ONO Region 8, DCPG 2: dchubp2, dpp2
> -	 * ONO Region 10, DCPG 3: dchubp3, dpp3
> -	 * ONO Region 1, DCPG 23: dchubbub dchvm dchubbubmem - SKIPPED. PMFW will pwr dwn at IPS2 entry
> -	 * ONO Region 5, DCPG 16: dsc0
> -	 * ONO Region 7, DCPG 17: dsc1
> -	 * ONO Region 9, DCPG 18: dsc2
> -	 * ONO Region 11, DCPG 19: dsc3
> -	 * ONO Region 2, DCPG 24: mpc opp optc dwb
> -	 * ONO Region 0, DCPG 22: dccg dio dcio - SKIPPED. will be pwr dwn after lono timer is armed
> -*/
> + * dcn35_hw_block_power_down() - power down sequence

Maybe add a simple explanation phrase like this:

   The following sequence describes the ON-OFF (ONO) sequence:

Also, could you create another patch that adds ONO in our display 
glossary at `Documentation/gpu/amdgpu/display/dc-glossary.rst`?

> + *	ONO Region 3, DCPG 25: hpo - SKIPPED
> + *	ONO Region 4, DCPG 0: dchubp0, dpp0
> + *	ONO Region 6, DCPG 1: dchubp1, dpp1
> + *	ONO Region 8, DCPG 2: dchubp2, dpp2
> + *	ONO Region 10, DCPG 3: dchubp3, dpp3
> + *	ONO Region 1, DCPG 23: dchubbub dchvm dchubbubmem - SKIPPED. PMFW will pwr dwn at IPS2 entry
> + *	ONO Region 5, DCPG 16: dsc0
> + *	ONO Region 7, DCPG 17: dsc1
> + *	ONO Region 9, DCPG 18: dsc2
> + *	ONO Region 11, DCPG 19: dsc3
> + *	ONO Region 2, DCPG 24: mpc opp optc dwb
> + *	ONO Region 0, DCPG 22: dccg dio dcio - SKIPPED. will be pwr dwn after lono timer is armed
> + *
> + * @dc: Current DC state
> + * @update_state: update PG sequence states for HW block
> + *
> + * Return: void.

I don't think you need to document return void.

Thanks
Siqueira

> + */
>   void dcn35_hw_block_power_down(struct dc *dc,
>   	struct pg_block_update *update_state)
>   {
> @@ -1172,20 +1178,26 @@ void dcn35_hw_block_power_down(struct dc *dc,
>   	//domain22, 23, 25 currently always on.
>   
>   }
> +
>   /**
> -	 * power up sequence
> -	 * ONO Region 0, DCPG 22: dccg dio dcio - SKIPPED
> -	 * ONO Region 2, DCPG 24: mpc opp optc dwb
> -	 * ONO Region 5, DCPG 16: dsc0
> -	 * ONO Region 7, DCPG 17: dsc1
> -	 * ONO Region 9, DCPG 18: dsc2
> -	 * ONO Region 11, DCPG 19: dsc3
> -	 * ONO Region 1, DCPG 23: dchubbub dchvm dchubbubmem - SKIPPED. PMFW will power up at IPS2 exit
> -	 * ONO Region 4, DCPG 0: dchubp0, dpp0
> -	 * ONO Region 6, DCPG 1: dchubp1, dpp1
> -	 * ONO Region 8, DCPG 2: dchubp2, dpp2
> -	 * ONO Region 10, DCPG 3: dchubp3, dpp3
> -	 * ONO Region 3, DCPG 25: hpo - SKIPPED
> + * dcn35_hw_block_power_up - power up sequence
> + *	ONO Region 0, DCPG 22: dccg dio dcio - SKIPPED
> + *	ONO Region 2, DCPG 24: mpc opp optc dwb
> + *	ONO Region 5, DCPG 16: dsc0
> + *	ONO Region 7, DCPG 17: dsc1
> + *	ONO Region 9, DCPG 18: dsc2
> + *	ONO Region 11, DCPG 19: dsc3
> + *	ONO Region 1, DCPG 23: dchubbub dchvm dchubbubmem - SKIPPED. PMFW will power up at IPS2 exit
> + *	ONO Region 4, DCPG 0: dchubp0, dpp0
> + *	ONO Region 6, DCPG 1: dchubp1, dpp1
> + *	ONO Region 8, DCPG 2: dchubp2, dpp2
> + *	ONO Region 10, DCPG 3: dchubp3, dpp3
> + *	ONO Region 3, DCPG 25: hpo - SKIPPED
> + *
> + * @dc: Current DC state
> + * @update_state: update PG sequence states for HW block
> + *
> + * Return: void.
>    */
>   void dcn35_hw_block_power_up(struct dc *dc,
>   	struct pg_block_update *update_state)

