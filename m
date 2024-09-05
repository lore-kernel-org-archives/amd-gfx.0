Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45696CD4F50
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Sep 2024 04:35:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ABF5910E039;
	Thu,  5 Sep 2024 04:35:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZcoGI/aS";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2064.outbound.protection.outlook.com [40.107.243.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8207110E039
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Sep 2024 04:35:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u/+FD1RSNP6k0lD7RqddZYFdFcV2nL0B66nKpWLVUmbCRX52z2NWmY1y+QLMGQf24hFXc1ZSgS0DVhmDovH1dlEZPK7IQtqFcLVXGpRZ4f2bCPW/w+mwmIbM1T3mPBW9I1+A67GC/D2iD/JQCO3RMujQ2Bi/Ld4auyTCNFwEmtXkX3/bcg7ZazsR8Gjek9UnE/AQT6rj8cBNtGFsAXCOzaG/qQEDlvXzbYodvESRChDtGcHnbtOA6FT7rmQT+qy81e50JiNth7sTw93y/lPFi6/4AD6gHdHK/IeDUI1sIT3Q1T01gIcSK1Iq9z+D5JM/eHJ2ebUO5khQnl6gAgy2bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/RuV0tHem6qdI+7Qv5E3rTKUjncB91MXR8tedQgeIhA=;
 b=sTDZge9pDMYBDvoMJuOkAvz9cQ4CETKN+eS12Gk4fwMKtKf1l0Z4A4EErRmy9XMA5gcgJCmE3SS9Y38YieJ0QOmJFxKKp+2AXqdmLRlhbhgkJ0Fcvv1/YiQL0cNPbW7X8CPHh6d4RXDxnW2/oUpUx/VK9tvdO1iN9s5jmY/jcvqUg9ujOb+pu+wwqvkqiHqXE527CgKrVYpWUS3pbjtko9bzJfIMCuxrcnwqpfiSdhiB3lU70ZA+dP6LAlQhWn01doxM/zfyzxfEoQar3KG81WaYlVEnJylA/0NoFHDCEHM9/fK9RcbXgTn86dJrpgKpKuYkejMgcAI+5OVasPA7+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/RuV0tHem6qdI+7Qv5E3rTKUjncB91MXR8tedQgeIhA=;
 b=ZcoGI/aS0fO7FubAN2YwztAh4gA+tUkbdpMJt+TMVf+vEu35IEkwm3sVNE8ISA737W/iEOER+lGPnQd9XDbaI7wAy2TZhlhI2YDS8fbmRsjftx4Za0vDThpw61n/Z3u8ipvJxekgWPW0CBOyb8r8wGbFj9JN9gdNrZA8KFlfnXY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6611.namprd12.prod.outlook.com (2603:10b6:510:211::11)
 by MN2PR12MB4318.namprd12.prod.outlook.com (2603:10b6:208:1d8::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.20; Thu, 5 Sep
 2024 04:35:38 +0000
Received: from PH7PR12MB6611.namprd12.prod.outlook.com
 ([fe80::76d1:e471:c215:4381]) by PH7PR12MB6611.namprd12.prod.outlook.com
 ([fe80::76d1:e471:c215:4381%5]) with mapi id 15.20.7918.024; Thu, 5 Sep 2024
 04:35:37 +0000
Message-ID: <f3ab9767-27bb-4d9d-a41d-da2c11b60445@amd.com>
Date: Thu, 5 Sep 2024 12:35:32 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: Add kdoc entry for
 'program_isharp_1dlut' in 'dpp401_dscl_program_isharp'
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Roman Li <roman.li@amd.com>,
 Alex Hung <alex.hung@amd.com>, Harry Wentland <harry.wentland@amd.com>,
 Hamza Mahfooz <hamza.mahfooz@amd.com>
References: <20240904074331.1733704-1-srinivasan.shanmugam@amd.com>
Content-Language: en-US
From: "Chung, ChiaHsuan (Tom)" <chiahsuan.chung@amd.com>
In-Reply-To: <20240904074331.1733704-1-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYCPR01CA0110.jpnprd01.prod.outlook.com
 (2603:1096:405:4::26) To PH7PR12MB6611.namprd12.prod.outlook.com
 (2603:10b6:510:211::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6611:EE_|MN2PR12MB4318:EE_
X-MS-Office365-Filtering-Correlation-Id: d47fb15e-d09b-4484-3be0-08dccd643060
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WWhGL1ltTUcrNm5FSC9zN1l0V05wNWNkSUtKdHJhL3VKQnNUMVB5d1dBTWpQ?=
 =?utf-8?B?blpEM2VkKzhKSE5HenFJSHFHY0UvelpVb1IrRU1xUndBL0p2L0lmN1ZXMXdu?=
 =?utf-8?B?NUgxaG5OK2JjTlVaZDhVRFJySTF6UkxYME0zMWt3czVaSHRqR1N2RGxkTVdk?=
 =?utf-8?B?dGxObmtsblNQTXBidkh3NVRkbjJUYTM4S1p5RGxIeXlsanJjdnMzR3RENjRP?=
 =?utf-8?B?WVhJaFd0em5xaE9vNUZNZXpBZGxqbDZXaFVYMEhISEZKbGc4cm1nemFvbFhF?=
 =?utf-8?B?eVZQUFNBQ1UwQWFjSkpQWC9iOUJiZkVLUzRpdkZXOVRoSGRpMkxRTGlwcVN6?=
 =?utf-8?B?ZUJzd0N4MVp4UVM5aGUvT2c0eWxRKzR0cVEyYm5HV1pzOENCYWl1RXdidHVZ?=
 =?utf-8?B?SmhnaUFsM3VXVU4rcHRiY2R3OHhjUXplcDVGQnplL3BwaFdiTWViTkVrZlN1?=
 =?utf-8?B?d2RKK0RYdTdLcHd1NHMyYjIwb0xXak5OUlhyYktKbW9VT3BKWVZFNll2OHd3?=
 =?utf-8?B?WG83TS9vYllsbWlIVXRRRW4wa2VCdkYydVpKc0Y2NG1jUTVOOVJ2NTErbkZC?=
 =?utf-8?B?OWxvb3JqaE85YlFUL3dlL2pGdjR4TmFCcmhRT3B1eEgzVWZCWTRZV21sMkpy?=
 =?utf-8?B?K0gzaE5CQVpoc3hxUjlJRHlFRHpWdFVEcDE3QXVBaVlSUmdpY01TdmNxNGtx?=
 =?utf-8?B?VkRHOVkyWU9SV0lvbHpnN3pMTktHOHBFUjh5RktEQnJESUtjQ3BPcnRRZDI2?=
 =?utf-8?B?VGxiandRaWVqYld3NDJ1VWMxZjdSUGxuZU8zV1pNZjBUMndwNThMRTZWN3kr?=
 =?utf-8?B?MnVYbTRiVkhmRXJ6aTNCc1kwUTUxVzBQcXRYQ0wveUc4LzJtdDBaQ09ob1dl?=
 =?utf-8?B?VlBCWmRHMGpSWWZuUHpCTlNSOUxvMW1EUWUwd0RjcDJ3azZlQkRWUmt4SGpq?=
 =?utf-8?B?SHBublkwL2lmQVZGN1AyWGcrMStET0dwUmhGeld4cE5sYnZKcjVWMmxLQVd5?=
 =?utf-8?B?QzRHOG4vUGRRVEREbjdsYmo0MGdFczhtNXpmVklxc0F4TDA0SUhGSUQ2WjF2?=
 =?utf-8?B?UklmeE5iWUJqbkdiRExPc1B5bTU3OG5wMzFiOUQ2NklVN0dhQUVCMHo2Unhl?=
 =?utf-8?B?OHZQVk04dXpGOGJVMEVmZXhQVUpONGdiYUVndSt3YWxzVlJ6YmFUVlIxTjZw?=
 =?utf-8?B?YUtEd0RodHhBY3AzdjdGR0VNcTM4Q3Fudm1iTEVlbkpWc3Fuc0Jtb2xQTjFN?=
 =?utf-8?B?TUJZdWx4eTdGeTF6aVZoYXpLeVA4WVFRTXlZb0Q5b05Td0dPRDlUdzBMMTlz?=
 =?utf-8?B?dytsdmI5S2N6TFdrM2dmeXlBdkFxTUtIcWkweXVRVi8xWWZ2Y3ExVmJFblVN?=
 =?utf-8?B?RVg0OTF0SVVyQVMwdnVMUEI1cGkySjRicml2YTZ0ZlM1K3g3MFBOT1FLWTh6?=
 =?utf-8?B?dUN6Qm1tNWVFdGtSZlBOMGUxbjdLUUNoYkJERExpVk1uMk83SnFqekNhTnl0?=
 =?utf-8?B?WkJDaFVCQWR6cWNNaTZXZmRNTDI0WStxK3NPNWNvV0ZXUCthanMvcG1TOVU1?=
 =?utf-8?B?ODVDVG5vcmtUU054TFVZb2E3eUQzZU9mMm9tUGR3blFPUStPMzNaekpQQTRC?=
 =?utf-8?B?TVFyd3lTK1lEZmovUWo3YWt0WmNEZHV3N21QNXdmV1o5YUNnRnNKcHI0YVBt?=
 =?utf-8?B?TVhralRlejBGZjl6aDFPZHRwQmJpemNPdjExYlBlMUVxMVFpMlBvU2cyUjAv?=
 =?utf-8?B?ak9RcC9WUGlDbjNkVEQ4eTEwUk82U3dXZGJZR0tpT2R5a091Y0ZGcFp2S0kx?=
 =?utf-8?B?Y3QrcEkvUXhyQjFCZnNrZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB6611.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NTBBbWlWRHRaUVNMc3VTYlBBTmJxeXNjM0lTelAvd2dlcWJPWU5jdFZ0WlQv?=
 =?utf-8?B?SklONHpTUTJjUnRjeCtkczkvVkxCZWdiaklIVmxDc2l2UG5rVUEweEFwUTc5?=
 =?utf-8?B?bFBrYk9vMGtLRTF3QWJCNlhnb0FxeUw4YnU4OSsyNTRQL1NvN0E3TWIwYjhn?=
 =?utf-8?B?ZDcrVzdtYktEdUZwcEFjUHVFZDA1Tm9FUndaS01Qb3dqTDlIdmU2UXl6SHZt?=
 =?utf-8?B?RnFWMTg4ZCt6QjF4Z3BXUlVJQUFvakpCRlZ3Wk9uMWFyMjZlWE9oeWtoNlpQ?=
 =?utf-8?B?WU9iYUlEaHk4VUxXNXJRaFNHa2hWeEdSeUQzOWhuK0pWYXJCeVlaa0E2cjBq?=
 =?utf-8?B?NEdFcFl1NWJUVDkxK1c0VWhGY3oyYlpWdy83RDBLZytGU3ZXUU00ek1JWCtD?=
 =?utf-8?B?M1VVVG92Q2V2SnhrQ2F6ak4zaUF4YjgrbnlGbC9oUFM0OGw1RCtUVzdnUVhY?=
 =?utf-8?B?aHh6TUJNVmZmdmoxZkViRlkxZ1IxMGt1aytSNDREcmJ1MXRKTkorUmx3aC9S?=
 =?utf-8?B?dTFCWHZJQzdlV0t6NmtVeVhhSEVUVlEzZTVyS2RMWE1OTEx1SmQrdWRNcU9l?=
 =?utf-8?B?S3A1ZUt5ZTJFVkxtN2ZTdkJBV1MwdVhwSm51N0k3WkNKYldnWGxQVVdWQXVV?=
 =?utf-8?B?SzNrUHFYNGx0bldkWGJLdGNEQ0ZhU2hwVTh2VVY5QTl0OHlabkprbmo2SXFB?=
 =?utf-8?B?eENRMlRTc0oxWTRNT3dRbDdtbTVXejZLZy8wbENkdjRPZ1czalF6UDRyYjkv?=
 =?utf-8?B?c3FSdDZCbnFUS3daMG9RaGJ2em5jTDRTSUhlWGdTL0ViWnhNOGcyYXFEbW5y?=
 =?utf-8?B?c1JwZVF2ek5yMFNMSllNdFlHc3lsalU2a0twd3ZPTkZFL29pamJudzlyQ3pP?=
 =?utf-8?B?UkZoaUo0a2Q5eCtsNXpndmNmV2N6SmhGc21XT21lNzU4NFAwakVnQkVEZTZy?=
 =?utf-8?B?V0poVGtOaTM3czR6WlNZOTlVbHdmWkV1dVV4VzBlWEJhc0ZxWVBDb0RtbUlQ?=
 =?utf-8?B?dktRa0t1SWxaTU1XeXpaYTBnK09UbnhLSlJMNEVnczJOcnh3VHdYSm5NT1RO?=
 =?utf-8?B?LzRNeDZ3U2tXa1VVUElKaTZDTXdvcWpNQkFoZ0F2ZEVoTTRMbUE0YUxxODI0?=
 =?utf-8?B?MVpKRUJUdVd0Y1Z6MU1FWU52d2k1OCtvSEcwUUNYdFcwWmZObVFCRklhWWZm?=
 =?utf-8?B?dTdXeTYzbUhzYkExRGdLblBpRHZMdWFLTEMwZHFLSmorNWpuYWpGNjdEcTM2?=
 =?utf-8?B?a2xrTXlhRDY3NWs1M3JLclZvUE92aEVMQmhkL0pGUEprRi9UdTl3cU15SG10?=
 =?utf-8?B?RStGck1pNTZlRVRPYkJPa0ExTksvOEYybi9VUUtvQWtxK2JPc3pnNEkyVEFD?=
 =?utf-8?B?SnNtUkwwdVdCU2F2dTRWdnEyNmtXMS9CZjFJMTIxK1ExY0NvREl6Z1BwSXQr?=
 =?utf-8?B?bkM5emFSbitVMytqa2NNamdOSXZvUGcweFo3Z0RtR3duRWtRS2crazBSNUoz?=
 =?utf-8?B?ZERqQjY2aVhNLzlJZTFIRFhHRW5zNXpERDlRNG5SbS93S0t2dHg5TFg5K2Vr?=
 =?utf-8?B?bGJJTzNTcXliaEpONnRiRkw2TmFKWHZPemJRR3VmQXVhbVlMNGJiRHQ5dnNI?=
 =?utf-8?B?R1BwakJCWGxIRmhwYi96OXg1bDdZQXdvVHptaVErNWVWS0s0K1Z6VlVBMlJp?=
 =?utf-8?B?Sml1M1RsZGx6NnVyRXVFN2FUbTl6cFJjbFhPYTdtK0liU0Q2ZUxNKzNlWGxI?=
 =?utf-8?B?L3lveVpkMjBxQVhEMnVkblZSMU5yWHhDazhweTQ3WUpTL2hCV2g1NEI3YUdU?=
 =?utf-8?B?RTRYMUo4Wmlvcng4MUxaMHBaT3IzSktncjBJaTBCaVZYV2x0bVpYZ01teHcx?=
 =?utf-8?B?YWMvM3hqcGIxdS9UQjhoM05uVTJTZ0xxUnA0cnYzWDlLU0lBUXo5OHFKam1w?=
 =?utf-8?B?T2xiUnpsOGhGcmZGazhaU0w4TVNuNDFmd3ZPWEV4b05weWhSLzVQdW5MQzlO?=
 =?utf-8?B?R2czQTB1a2k3bnpYcnBtKzgwdmRCM01WOUp6YWJFN1FOU3BRNnVZRjJ4S0My?=
 =?utf-8?B?cCtWMFJDREtNbWVSMlNFWmV3bHRxZkZ5M2NLMTJvTklrMFBMSjBUYldEdnlz?=
 =?utf-8?Q?uFVM9niFAlU6NMt/F2UihK++o?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d47fb15e-d09b-4484-3be0-08dccd643060
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6611.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2024 04:35:37.4069 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8S7Qw47ef8Q/v4+HJgHJdjgztkAaWQKQVYOTo3EHfVUOuheSS2phD9YZP7ctgXozm2NhMhOTDBlPCQUAh9cpMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4318
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

Reviewed-by: Tom Chung <chiahsuan.chung@amd.com>

On 9/4/2024 3:43 PM, Srinivasan Shanmugam wrote:
> Added a descriptor for the 'program_isharp_1dlut' parameter, which is a
> flag used to determine whether to program the isharp 1D LUT.
>
> Fixes the below with gcc W=1:
> drivers/gpu/drm/amd/amdgpu/../display/dc/dpp/dcn401/dcn401_dpp_dscl.c:963: warning: Function parameter or struct member 'program_isharp_1dlut' not described in 'dpp401_dscl_program_isharp'
>
> Cc: Tom Chung <chiahsuan.chung@amd.com>
> Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
> Cc: Roman Li <roman.li@amd.com>
> Cc: Alex Hung <alex.hung@amd.com>
> Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
> Cc: Harry Wentland <harry.wentland@amd.com>
> Cc: Hamza Mahfooz <hamza.mahfooz@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>   drivers/gpu/drm/amd/display/dc/dpp/dcn401/dcn401_dpp_dscl.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dpp/dcn401/dcn401_dpp_dscl.c b/drivers/gpu/drm/amd/display/dc/dpp/dcn401/dcn401_dpp_dscl.c
> index 8564369f09b4..5105fd580017 100644
> --- a/drivers/gpu/drm/amd/display/dc/dpp/dcn401/dcn401_dpp_dscl.c
> +++ b/drivers/gpu/drm/amd/display/dc/dpp/dcn401/dcn401_dpp_dscl.c
> @@ -951,6 +951,7 @@ static void dpp401_dscl_set_isharp_filter(
>    *
>    * @dpp_base: High level DPP struct
>    * @scl_data: scalaer_data info
> + * @program_isharp_1dlut: flag to program isharp 1D LUT
>    * @bs_coeffs_updated: Blur and Scale Coefficients update flag
>    *
>    * This is the primary function to program isharp
