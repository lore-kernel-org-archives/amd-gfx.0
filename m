Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44A34CCF9EB
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Oct 2025 11:47:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D2EF110E7A6;
	Wed, 29 Oct 2025 11:47:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mgfg2LZJ";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010047.outbound.protection.outlook.com
 [40.93.198.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D276D10E7A6
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Oct 2025 11:47:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xIgCPRXVXXeKmdSHMf/May8kzkVgd3RCd4CqdnCe+JU9Gdqjhmlr8CGVpqVchZ9ZFn/iG0SA9hwEzRnJW//aZgAsaToTJiIOHJ6dyQU4nB3oB1LM6Maq3GySAmzbh5ooocY788DRn8ltD3Zo5vuvM7BMXy87BCfYlOTljkYgGW+VqSmxUP44WByfAaebq8LBz1gbGsiBoh7lHGKLj6ROZ8TIERryZolEzTuJkPWuCxAxPboPBzJErsK/xYAdp9bAIpexglvQ9KUGCykge9rDE0+beMkbeCyVgRalcDiGUfTTOV8ORTSSDFKi5bpEofjmrfmg3+6BBqKAeIq4RVFssg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xzpy0m8NkbnGLd2jJD5XZ1buGvyrIGlc/zdLtY1cr58=;
 b=L0AartawtRWpowKTCk5LUxGZOwcBEiJ0hK2Vxs2e8up8OaTjHs3mQqSU+yt8zxPNZKjfy1W/BEMB45hx+Q3SGVCpOV6J5+6pcK8kkmzSI2wJ4M/9O1R97pOrPZs30n2YpM/ku++Jp9ViKEBEbLcR0FDuBDogqvZkPD5iN3DJ9LigvW1eQwbDAgTxmV1lehoPf5bQ5jr2wVK607czEnD1Au6vieK0XfJ4lmqQ+OowdNBxOtv50pA9ZPommaWV/C2BnPYnZcZZar6ln2zsEUTFEicyWzDWCj4Iq6MlTdwWL1hzcfFC6rOtPFgVBgfMAfBi+tcG516cbaCn/1AtesN0Rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xzpy0m8NkbnGLd2jJD5XZ1buGvyrIGlc/zdLtY1cr58=;
 b=mgfg2LZJKg5LvFXr9I3z6P7VynEnBp2h1FczicZy45xc7/AVZZHylEqdm061KTnmC3duTNTBBLnDcu/1Xu/xzox6oEdukAPe70UsJDxVWmR6U0tNAIIGS+5jj9A7OW7mcNV/q8J4k+Glgkf4C7B9pEMqz9xwtBGPliZ1EfmYvUU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by IA0PR12MB8984.namprd12.prod.outlook.com (2603:10b6:208:492::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Wed, 29 Oct
 2025 11:47:12 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%4]) with mapi id 15.20.9275.013; Wed, 29 Oct 2025
 11:47:12 +0000
Message-ID: <0c109181-bcb3-4672-8145-48efde0153f9@amd.com>
Date: Wed, 29 Oct 2025 12:47:08 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/14] drm/amd/pm/si: Hook up VCE1 to SI DPM
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 Alexandre Demers <alexandre.f.demers@gmail.com>,
 Rodrigo Siqueira <siqueira@igalia.com>
References: <20251028220628.8371-1-timur.kristof@gmail.com>
 <20251028220628.8371-13-timur.kristof@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20251028220628.8371-13-timur.kristof@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0050.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:92::13) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|IA0PR12MB8984:EE_
X-MS-Office365-Filtering-Correlation-Id: dd0cb344-8b28-4e03-6757-08de16e0e5fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eHgwcHVjK0lRbW1kVE5pYTJpeVVhRXBDaFhoam1pR2tCbFRCOU5jaWVOSHpC?=
 =?utf-8?B?b0pBeFFZYzNWT3JnWEdOMDB5ZW1aYUd3RlZXOGJ4Q1drYkxTbk1sT1lJUTd3?=
 =?utf-8?B?WU1BQlc3TUo0UGx0MW9BYTZwUVI0TU5pRVlrMmVnQ2o0d0VXWG1kaERuT25m?=
 =?utf-8?B?YUZSZVlNbnhBV0M0WW52OGxDSG9pS1d1cC9Za0QrUndaUDJ0Wllvd3BwMHpI?=
 =?utf-8?B?d01OSFUzbTJNa1hNS2dWZ3FrSkw2SGFWSWh5WWQyTnN5dXpnVWJFN244SGVM?=
 =?utf-8?B?ZVBHb1RQN0V6bmNpdVF2TDIzMzVuK3dab05ISXRVeHRzS0VVd21nNDIxVWVs?=
 =?utf-8?B?S0d3bFE2RCtqRDhVUHBMWW9SN0dMT01HbHRjU2VaYkpabkpNdXJBbDVidHdz?=
 =?utf-8?B?ZnlSYWlYRStnSUgxamxIN2lEN1JENm5lZU9jNUhxK3F4SDZKV0l5Z3c0OHhI?=
 =?utf-8?B?a2xXYW5odEl5K29PcWFDK084aU5IOEU0dnh1RG1RS1hWTDlNVXNLV0l3a0g4?=
 =?utf-8?B?cmFxMmdKMHJSRm0zSTNQRmI0TGpabnFLLzVnQWhtK3pjSDVKVmx5dnI1ZU1T?=
 =?utf-8?B?OFZZYW9IbHRDMXlkbjZiK0dHaTQzbEVUZW50ZVBhaDE5bktNRitnSGJ4TWx1?=
 =?utf-8?B?QTdhbkJ1SmtOUjJ3VGZUakJoNWk2SWFuZTBad0VOYmJxeVlKZUpCeWhzN3dD?=
 =?utf-8?B?cGJDSitTODdrN0pEUDI0WndKR1lmMWJIbFBOSTMrb3dYWEZsdityTFFvUERQ?=
 =?utf-8?B?dmwzUEMyWjZGYTVPY3VmYm5DRll0YzBFaU5xeXdFQkxPcisveXhRTmZ4Tys2?=
 =?utf-8?B?MTlHMFFhYzdKYTRkMGMrQzBwSVBuUnMvZUZicGRaU3F0amlaN291MHUxVmNu?=
 =?utf-8?B?QzlleDZSMXhBUHVHSmlFcHdvZDMzclpVenFoS0RKdUpNMDdPL1ZoUTZUaGFw?=
 =?utf-8?B?YWY5T1NLaGJBbW8yQ1R6Sy9tY0U0SU16WWtKbEY2QWpvWlhTRkcvc25Fdnla?=
 =?utf-8?B?aGpEVmZnOFFxLzJMcGJzcnVidm1GUzFpZm00TE1EbmVtYVo4ZC9yWG9nYXVq?=
 =?utf-8?B?OWtabWJ6enlTNDVENC9JcWVYZzUwWDdLdXE3NWNiNkNiT3ZqcjJ6M3o2c2Nt?=
 =?utf-8?B?TzlZS0MvMFhJSFJiT2lIVkd3MjBiMHRrUWYxZW5xdTUxSEllSG9kUzRwU1d2?=
 =?utf-8?B?eS9vWm1pRWlXWmFFNGpzUlBQZ0V5V1NTNkljQVczeXZkdHdPWjFLT2tNY0FP?=
 =?utf-8?B?RFhYY3lSTjdaWVFiak1iWmdubXJseW5PdUhIY25qYnBueDRtSWMxZ05ja00x?=
 =?utf-8?B?c2FjQXlMT2tPSmh3MStFS0dYZnI5akZOSHRXSjNZUFdGcXlzcUFmYlRpMUxn?=
 =?utf-8?B?OWhkd0ZuNFpUQjQwYlhUUDkvWmVxUUZqSUkxQzUyb1pxNm4waE53SVpwb0tm?=
 =?utf-8?B?TytkSkJ6Q2VyTnhpWkdqbzBIRWFnOS9YL09TbzBWaEVmUktOdkszWHkrVDNG?=
 =?utf-8?B?SWx5N1pRT2JlM0NjWkhHOUhmMTdGNHhmZGxSRmVtNWxLUSt4ejhFSzQzdCt0?=
 =?utf-8?B?V215bzhEYTcyYTdmckhraklBaUw3MjRZbEVnOTlETHZMeE1WOU02cHU4eFRo?=
 =?utf-8?B?RjlWRmFleHdvQXNkdVMwakQrVklHKzQ2am02ZVVVRzRUbXAzRjNWcmdPbUV2?=
 =?utf-8?B?TW1HOXo3bVliS2RDRWFwdFZFcTJWc0JXMFNjcmJ0TjBXcGErQ0dVZUFpRlFo?=
 =?utf-8?B?WW1sYS9JbjJJdFJxdGRoRVpxMGJObDQ0NzIwdFlrRFRCVFgxcTYydkl6cGUr?=
 =?utf-8?B?MURpKzRIZ3F2bytKWE9WVDlqYWdDb2VSS3NmWGRTb090aTFqd1R5L1h1YzI0?=
 =?utf-8?B?bzg5NjErNldOT3Bydlp2b1g1M20veGpIUWc5OTZYVmVYWCtsdEEwZ3pqUjMy?=
 =?utf-8?Q?VQV6CA3WdxqthBWE/QfVrOvY0YH7y2WC?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YzdBb1VIN1AwZUpqYzNxOVpXdy9Xa3pXM1BNcUo4c1ZSYzdTcTJ3SHd6TWdh?=
 =?utf-8?B?Y09hT1Zjcm42QStTVkc4Q3N1M3V3M2RhZzNMa1dHREpqQXlBTGIwY3VnazV6?=
 =?utf-8?B?NkN0aFY3TWIzYlJJWTluVUN3SEoxM2Y3WTVxWi81MEM2NVV2M1psN3YybVhZ?=
 =?utf-8?B?RGtrZW5KME9Jck5OQ3huSzJqQm11cHFSa2VVM1h0QTJ3TVV2U2RoaS9xOHA2?=
 =?utf-8?B?NFJDV1hBbjVCYmhPWWU2SnhlM3lVaHc4cXJwR2tUSkVQSk9BV3lCaGx4MnAz?=
 =?utf-8?B?cGxZRUY4MTg4SnN5VEZRTHEraGxXR01VdTNDTlltODNoWWE1Y2xsM3JwZk1o?=
 =?utf-8?B?VEtVQzV5RnliOW5UMGFZbWJsYm4vWUJTUEt3M3EwQy81ZWYrZUM4cnpoaTJX?=
 =?utf-8?B?QkVOTDJjbmd2UU9iSElCNkNKREdwMjg1ckMxVEpqcXZRMk1od1Y1YU8vanlE?=
 =?utf-8?B?WGJncWUvWTVmNHRKai9rSGxGNE9CcEJYVmxITGQyYkxhenB4eFVYRE1RQ3FQ?=
 =?utf-8?B?dm1tWlR0THlqV2xyTktQYXZIdUJPaWdjMlhMQjBkMUFORzBOcHNUK0lXZ0x6?=
 =?utf-8?B?OEdOWGc2bTR3VlJ1alpIVWlmNDNTRlN4QitVNFZMM0RnQUlyTVVjR3pWbmNr?=
 =?utf-8?B?dm5RcHNtY3h4QjlvZklEejZJc0VxQ0p4L0hKejViU3hwaFJIL0FrSlA5Tzll?=
 =?utf-8?B?WDBiU3NpNkRleDRCVzFBRUJEeURhQ3dMNXA2OHFwQ3JsRGpYd0xGZ1B5TDE2?=
 =?utf-8?B?Qm1BQWV1eXVDVElEQ1ZjT3VvZFpmdlo4U2JiT3RPeXlkMm9QVy9JYmhGcm1l?=
 =?utf-8?B?UVczTmZXRjJxQzhBZXFvODI5K0YvUFU1ZTNTVVhpbEZWMngrbDE0ZlA5WGFU?=
 =?utf-8?B?anBXUU42bVhBNXd2eDJWTjFoQStNb3IzWU12bXhpSzlXQWhCVzFDY3MyeFBT?=
 =?utf-8?B?TjRubFJKbkd2MlI2bmxBK1lEenJZSFZIRGJHRWRGT1c5ZmZmODRZZ1owV05H?=
 =?utf-8?B?VEFFNUZrVFprak5qSmNlTXFVSHhZUmtCY24wclpEVms3WlFUcnFHd2FlcSs1?=
 =?utf-8?B?SkdIYlVKVUU0NkhlUFh2NXdXKytDck51RS9EQkM4d0FDTVVHVUVEbjZJMVZ1?=
 =?utf-8?B?d3VjU2p2SXo5VnhiMm9VNWVJTUc0ZC9jaDFWdDUzWEhpZWVZRjdIYjRKWVBs?=
 =?utf-8?B?M1FiZWh6ZzcwNkM3WHNkMDV5TDMzMkpXTGRSektOVS83ZTZIMkF1WXk2aERI?=
 =?utf-8?B?R2xsdlFEL2ZWNDVpU21aVXo3VFFvYldRRWVvOHVUQmk4VzROcmF6T1lKZFR1?=
 =?utf-8?B?UW1jcllFV0l3OVF6OW0rclA4ZjRickEzc2t4UDV2V1VZSGdNYlZUdUVhRnQz?=
 =?utf-8?B?dkNOMzA2UzF2MTU0dnJ3ampKa3IxK2EzK0lVc3dlZFVHSnduakFET3E1ZzlT?=
 =?utf-8?B?aWM0T0pRR015eFo0SWNqc2NiZ1dPU3FBdWVZeW04dlhlZ3Uzb3Fleko0Z2J4?=
 =?utf-8?B?a0xKd0lKOU13eCtTWmFBMEsvcUtHNVVyNktPUU00SE5sQUdaRlcvTjhKZVNw?=
 =?utf-8?B?RjludVNVWUJmUjBFU2lGenFQNE1JWnU4N3F5QkFGS1RLWFJXRXo3alFsYkFD?=
 =?utf-8?B?ZkVBK0lJMEZnYU9ZcDBKRGZkQXpIemQ2U2Q5NDNjTjlEaVdNZ2VxQ1h4d3Q4?=
 =?utf-8?B?YjFvUDRIaVRoMjRRaVJUQUM0dTQ2QlFSNkRQZjgyYUljMlJuYmVudDN5bmVo?=
 =?utf-8?B?V1NGQWk3bkZEVDhZRWpWREpsTWg0djIyS01YSXVXRGs3cjRma3JDanRvVVZy?=
 =?utf-8?B?Vk50cW82SlNFWko3U1BxWDQvZ0NoTW1LMUV6cmZvYnBjUTM4VUhQOUt1Wk5p?=
 =?utf-8?B?ekd0TDljaU5PZzI2YlhKZmFxYVdXb0VhckpTVzUrckFRWGpNTG9sZUNRZEcr?=
 =?utf-8?B?NjZkQ0xZdGdsREgvcUpEb0dpUE1YM3UrV0wwUk0wSDRpVCtPL21PQXd1QmdU?=
 =?utf-8?B?T1F4ZzBqcWpTcmZRTGhta21sTWI0L0pLWFlUc2hJbWg2QXoyc3dGanFuYnVn?=
 =?utf-8?B?ZDNrRnI2OXMwR1luOC82RnVNTWppdnNaWlBVSjc3SVU5ZkpXQU9SeGU5UENn?=
 =?utf-8?Q?mXG1UB0ryDNIiu34lgZi7JWSJ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd0cb344-8b28-4e03-6757-08de16e0e5fd
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 11:47:12.1536 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zP0uqUNkIiS0e7xe2MaluvciVi2qaUaV9I8idP3lR2FXknnzclxSUU1euomthEQK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8984
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

On 10/28/25 23:06, Timur Kristóf wrote:
> On SI GPUs, the SMC needs to be aware of whether or not the VCE1
> is used. The VCE1 is enabled/disabled through the DPM code.
> 
> Also print VCE clocks in amdgpu_pm_info.
> Users can inspect the current power state using:
> cat /sys/kernel/debug/dri/<card>/amdgpu_pm_info
> 
> Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>

Alex should probably take a look as well, but from my side that sounds reasonable.

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c | 18 +++++++++++++-----
>  1 file changed, 13 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
> index 3a9522c17fee..bf7ab93b265d 100644
> --- a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
> +++ b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
> @@ -7051,13 +7051,20 @@ static void si_set_vce_clock(struct amdgpu_device *adev,
>  	if ((old_rps->evclk != new_rps->evclk) ||
>  	    (old_rps->ecclk != new_rps->ecclk)) {
>  		/* Turn the clocks on when encoding, off otherwise */
> +		dev_dbg(adev->dev, "set VCE clocks: %u, %u\n", new_rps->evclk, new_rps->ecclk);
> +
>  		if (new_rps->evclk || new_rps->ecclk) {
> -			/* Place holder for future VCE1.0 porting to amdgpu
> -			vce_v1_0_enable_mgcg(adev, false, false);*/
> +			amdgpu_asic_set_vce_clocks(adev, new_rps->evclk, new_rps->ecclk);
> +			amdgpu_device_ip_set_clockgating_state(
> +				adev, AMD_IP_BLOCK_TYPE_VCE, AMD_CG_STATE_UNGATE);
> +			amdgpu_device_ip_set_powergating_state(
> +				adev, AMD_IP_BLOCK_TYPE_VCE, AMD_PG_STATE_UNGATE);
>  		} else {
> -			/* Place holder for future VCE1.0 porting to amdgpu
> -			vce_v1_0_enable_mgcg(adev, true, false);
> -			amdgpu_asic_set_vce_clocks(adev, new_rps->evclk, new_rps->ecclk);*/
> +			amdgpu_device_ip_set_powergating_state(
> +				adev, AMD_IP_BLOCK_TYPE_VCE, AMD_PG_STATE_GATE);
> +			amdgpu_device_ip_set_clockgating_state(
> +				adev, AMD_IP_BLOCK_TYPE_VCE, AMD_CG_STATE_GATE);
> +			amdgpu_asic_set_vce_clocks(adev, 0, 0);
>  		}
>  	}
>  }
> @@ -7582,6 +7589,7 @@ static void si_dpm_debugfs_print_current_performance_level(void *handle,
>  	} else {
>  		pl = &ps->performance_levels[current_index];
>  		seq_printf(m, "uvd    vclk: %d dclk: %d\n", rps->vclk, rps->dclk);
> +		seq_printf(m, "vce    evclk: %d ecclk: %d\n", rps->evclk, rps->ecclk);
>  		seq_printf(m, "power level %d    sclk: %u mclk: %u vddc: %u vddci: %u pcie gen: %u\n",
>  			   current_index, pl->sclk, pl->mclk, pl->vddc, pl->vddci, pl->pcie_gen + 1);
>  	}

