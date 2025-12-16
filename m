Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 535D1D5C0F2
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Dec 2025 08:45:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E08B510E77A;
	Tue, 16 Dec 2025 08:45:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="aXxuUee5";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013061.outbound.protection.outlook.com
 [40.93.201.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D164410E77A
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Dec 2025 08:45:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qJvwkMhS4tq4sEqjk1UBTll+Sa6G49qjqHmCed4R6RdBdz1zkHNPrShJzPbwYRB+jE0JH2stEXi/NFvjjxSyAckqB+AgzRuAwZx8ooJmzxDLzq01QmiRunlDKQiN4XvdphlgV2izeb0vIOJ6oDrYhDkeLgXzpKqQMZ8/cIbNhESXNd2VSppY2m/KyaNuqXWbtyjXZOrjGcWEA69n+iHDASeEDj90ZlNmLjn8EEYJSDsrIEtscGJHzl9+mbjdGcgpN8MEvyk/NHB2uI4Pmmqd2dYPMpTEIEu5ihHC5j3wGlozHlengfYa56tZYbKwlOdLnHd+8cMoYbh5hmjlcA1F+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZGk6mPOc+Cx0OiCibQZC9eepMg5HcRYQnmXyj0KU8pA=;
 b=ENP3fw6g22voTsTAsGKcoWFOhf97kOkBCG2JLJ5lxWa3udzGBmjPslxydhqbSrh6iRRoruEdidvonlTZJRh6tcjIrg5pipWHfrDg7POmVPdcoVVS4mTBH6jAUDTcyNL+OWKCRxNcDXJGF713beqq3/D/kel0Nd7Os6eIJhT10k9GpgriBmuPkSth5DEr4cEPKqBiwlkItbumIH87krNLpNd/V1GApc+SQLIXc37EvPKyAOZQlhhqMlCrzSTZIgbhylG4aeV+8zTKqKmoUgXTBLxOR38Sk9vNK5mFP5Yv0s4ZLJ5QwZW4Q3NWkB5chfCKPdLRIzlAGBUjt0BgD3xymQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZGk6mPOc+Cx0OiCibQZC9eepMg5HcRYQnmXyj0KU8pA=;
 b=aXxuUee5TD2EZnBLtqKW5CH7Mg2ZHq4W+/LA4d1TaZE4kVjr/klLXfCg82Sh7ld6MQe5CGnQtwaMskYt+8kJTgKoqJ5IjD33oykSQVyn/3DXFtBkGL+MGRVNH9EkpRSWmVkXqKEGYYkDheZBuL5+BFvoRNaOkxkpMwUXOxP2jjk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CH3PR12MB7643.namprd12.prod.outlook.com (2603:10b6:610:152::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Tue, 16 Dec
 2025 08:45:36 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%4]) with mapi id 15.20.9412.011; Tue, 16 Dec 2025
 08:45:36 +0000
Message-ID: <b6d969d3-ffc9-46c5-a8eb-c3d7b62ea880@amd.com>
Date: Tue, 16 Dec 2025 09:45:31 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 5/6] drm/amdgpu: Add helper to alloc GART entries
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Felix.Kuehling@amd.com, david.yatsin@amd.com,
 pierre-eric.pelloux-prayer@amd.com, kent.russell@amd.com
References: <20251215165630.1172383-1-Philip.Yang@amd.com>
 <20251215165630.1172383-6-Philip.Yang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20251215165630.1172383-6-Philip.Yang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4PR01CA0116.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d7::27) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CH3PR12MB7643:EE_
X-MS-Office365-Filtering-Correlation-Id: b8691132-2432-4a81-39c8-08de3c7f7bac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WkZpaTlVdHhDMytnTlRRZGZmNlNhK1NwbmFKL3JWVWhTU2hJSUIrQ3NqV3Nu?=
 =?utf-8?B?V3lxYXd2ZVZGU0tZdUFGWWNiN0pVeGNSV0ttVzVKRFZMK1EyNHRXeUxhZnJ2?=
 =?utf-8?B?UjBYM2xqSzlJRFZEZlZORnpiS1YyZWhRRDAvUnFMQU5LUHNnakNad1F4Zm03?=
 =?utf-8?B?NHJsOVA3dnZiaGYwd0UxMzVRWnU5V0tCYllRbTVrTytiVk1hUW11bTYzdXRv?=
 =?utf-8?B?cm5qdWRSeXI2Q2VCNHdGb0x6Q2tGM2l4VjJ4bmpHMHVMbnVnZFZUUHJsZDBS?=
 =?utf-8?B?VWJVUUVRZHFBNFc3VmZKVEpDMzJDVHlabmVDODVpNEJLbW9IN1lsTnVNRGsr?=
 =?utf-8?B?c1JZdCtvYVNkKzZGeVB5SUV3bm9JSFRENkw4RE1uR2VxUi9WTzByajE3UlBK?=
 =?utf-8?B?UVNtdnF5Tk96aHphYWphcjd2LzlZN0lIYW9BVGowcmQxODhKNmJQdUhZa1dE?=
 =?utf-8?B?cENuUFcxaHNyWHFVNGo1UmNCaitHSkRRK0Fpem1xWHNoT2dyOENnaXlvb1dK?=
 =?utf-8?B?RXBrYWpEMHFNeVpZTnpqWWRCSVVqOEJDNHVYN05GNFFmYldTQlAwWm9qcCtj?=
 =?utf-8?B?L1JSRlQxWHFLNHlndW5OZisrQndDeTFVdnRKd0hCanJWanJZNlMvYlBGVjFl?=
 =?utf-8?B?dlN1bmFkOVBEMVRGdHJqUTNYOWVEY0o2aGpFOEJGdGVaa253ek1nVXliVXRI?=
 =?utf-8?B?YWxvNGhJSTNGa01sdFE1UklZeUtQS3FTaGVEdUlUYkZFTG5tU3pyYWpRcGF6?=
 =?utf-8?B?UG0zbjNjdmUrbnRXNG1ka1F4VVNSVDZ1MGZKZG1HQjFpd3hUMXAyeUY0cHNF?=
 =?utf-8?B?NFV4Qm8zK1puZlJuTTNjZUtjb0VrNUtXekE0bmgxT2dFN3VFREplY2VWYUl1?=
 =?utf-8?B?L0x5MjBHWmhCNnEyN2JNb04veDdWR3J3czJjNmh1bTRNcVdpakZ6YmpDckYw?=
 =?utf-8?B?T25NN0E1bElSYnp1Z0grdnZPdnhmU2RkaXAzN2Y1NURZcmE2eWZwbW9jT0xZ?=
 =?utf-8?B?NHNjMFFiZS8zVmdVMGZkNmdiYnpWZTdUTGdNb05lcCtiYmVxWFh5eVB4aUdV?=
 =?utf-8?B?R29nL0ZvZlNiaExPbktpMjRvWlZyUDk1bEJwb2dOWDdZZmxLVWZvRzdLMzVv?=
 =?utf-8?B?UlJVZzNMTVh3bllxVS9EakJOOS9GYUpIN1VkVHRkcTZtbXJsaDlkaUdPK3g1?=
 =?utf-8?B?ZFVhSEdxZG9RcmNHK3JKZTdWRzMzZys2NVdIVUc2SmRPL3l4RmpPaW4rSFgz?=
 =?utf-8?B?bTNqdGloMlRxZERRQmZTN2dmdmd4RDhyYmUyNThacllsQnlMYVp0SVl1UTlZ?=
 =?utf-8?B?cVMrYkJYdTU3NmU2WXU0cWVQOXF4d2Z0UDRlSGtaNlRkVEU3dnhsUk9lRWFF?=
 =?utf-8?B?OXN5WXVXTzAvNUlETlZxK1BMUTZta3o0cXR2UitXOVY4eUNMWWtMUWRSTWpu?=
 =?utf-8?B?MXJ3UnhkTXZHWjhsMjQxbkhBUFFHaFNRZzc5S2V1NnNFdGdueXhBVXAvejJp?=
 =?utf-8?B?R0U2K2psM0lDbmVDaEhNMUgxRFpCM0c0emZVc2tUblBOdG41MjBLSm8yVzUy?=
 =?utf-8?B?N1hNWFIyeUZsRW4yYU9PWDFibFhQdHhiL1JPNzBtWW9XbWFldXRHeHZvR2JW?=
 =?utf-8?B?U3I5c1VXUGNzZVdlam8zc2RXQS9qRVpKbXVIZE1jU0VBRnc1cFYwZDVNRjdo?=
 =?utf-8?B?THhhR1NwemgrVUhRMDdkUURNTHlETUZBbEh0ZFQ5c0ltM3JUbVQrYUlQbVRi?=
 =?utf-8?B?T2R3NnprVmROMnBMa0ttREdieDZ6cVJScFlJK1piTTNmZmRweGQ2bVZud0ZM?=
 =?utf-8?B?MWduUThRU1c1Y0RoQ2VreU4vMVlLazlWeGpHYmN1c2tvNFhlNjJpYVZBUTlz?=
 =?utf-8?B?L3dtWjdyQy8wNGh1YVEvY2ZjeDdmRUIxaUFMTGtnTDJlbm4wazhYQnA5ZUo4?=
 =?utf-8?Q?R34JIxFmct/zsyB28wI+citsRmvYPZ+n?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?STVVazdCRFhpQUVubDdTOEdydUVocFFVTzVwdGw0K0h4c0tIY3hGa2lHUG1J?=
 =?utf-8?B?bDlYV2crRnZ3VnhSdi8xYzE3d0RHL2tjK1g0R3FJQUE4YXZRM2FnU0lMSktn?=
 =?utf-8?B?RklWU3krdUxmaWxsVFpBLyt2ZlA1RENEMmhDZXF3bnIvSy85VENNcjFxZm9J?=
 =?utf-8?B?TWVyVUJFRlgrTU1LZkxDOTJYQlE1Z0hEUXVJSGVBZjJwc05GMWZwTkloWkJC?=
 =?utf-8?B?QjVld0xOTGZxdklrYnlqS0RzSzZKOHVxYXBoUjAwK3RISDZKOEJsNTk4eXYv?=
 =?utf-8?B?RkFUZGpYVHZZMk1oWGlhZGo0QU0zdGVZdU1jbHdiZzJYOUpoaHA4dXp3Q2NL?=
 =?utf-8?B?SnU5MDZMQWVsNkZCWFVPQjdNOEdxSVIyazRSb3d5Y1lRNHdMQjcxUW5RTDRh?=
 =?utf-8?B?cG05UXZNRVh5UE0waXJXT2NzQW9mNkptOVFlay9Jd2c0ZG94VS9DM1pQNDBr?=
 =?utf-8?B?V1Z2dWtFcTltZlpDNHdpUENMNDJGMkFZNG1WM1ZPSU1hb2M5MFJrZHZSZUVE?=
 =?utf-8?B?anFieUFJZ3VMT1NJWHZZOURpcDY2aHJVNktNVkdXVWgwL0lualBWalBzd0l1?=
 =?utf-8?B?WXhBdFA1elpkSjJ4eUpOM2k2ekFpSGlLOXJuckxCSStjczJlcjhyWFhCNkpt?=
 =?utf-8?B?ZVJvdCtaWEI5dVg2dlFvVmlDV2Fja0pZTExYNVRmUW13czNpQlB4RXlLNTRN?=
 =?utf-8?B?VnUrMzdES0crY1BwL2pYVDZ6S3QrbE5GZENnWDVKRVAyYmp1Q3VOcTc3Qk5h?=
 =?utf-8?B?UFMxd1VBa0tlSUhiZnNlOUJGaENUNXRGUnJtNVlhYjQwOVcvR2dwbHcxVXVF?=
 =?utf-8?B?bnJyVWJ2NGtnNkhLNTh0RlRXWm5IejFlU3ZtZGs2SnE4cWZyaFdFWERNZENn?=
 =?utf-8?B?S0VMRGJIQVFaRmFTeXA1aUFNeVU0Tnc0TEZ6My9Ta2FxUXFvZkF4TnJrcE1S?=
 =?utf-8?B?V0JEelh3dUppdkdLc29XcDlXVXBXbnBGZFZ4R1N6YVJqM1BycE1yU1dXd2Jl?=
 =?utf-8?B?Z2svZlB6ek1vMXlyRDJDRkoxN0lXUXlieDRuUEtDNW9qNHIyZmxGVVZGeThR?=
 =?utf-8?B?dTdVdTYrbHNoUEs2MCs5dDFJbnhkUHNjaUlqMkFUdjdhWWU0aGFSRDFPRnND?=
 =?utf-8?B?Unc0Q2FoOEVUZG1icGtSRVVIYnAvYll2SlMvRnBqSW9mWElTL0NpeDl2Y3Uz?=
 =?utf-8?B?Qi83VWpTeWFWWUs5MzE1Q1ZkY2FRTWlVeWxqbW1hL3BZNnRTTnJDY2JwbVZy?=
 =?utf-8?B?MFA2MW5SeXExSkZ6cE5YSVBPRTBFUWU0MytUQUhMTWM4ZzZPdWNWdlJpYy9E?=
 =?utf-8?B?dzh0aWUrZ1RTaklwV3p4KzBmNXBidXdXbjc5RHZKS1ZreTJKdXdLeTJFdlk0?=
 =?utf-8?B?Q1dYOEFoMWhPQlJCbFFLeG9rWnU2TjM1QWFwYWFyNXR1L1YwL1dZNkwwU1Mz?=
 =?utf-8?B?SXU1SlFVU0FRVURuaEdMNjUrT1NBQ3p2SjdtMmZjNjk5WEVOSVQ1eC9OV3Bn?=
 =?utf-8?B?NkhGYnRJejlPVzVqTnMyUmZsb3Bwayt5cDNVa2xBdVZPMW1Sb2EyVXdtUzk4?=
 =?utf-8?B?WWJRUm5ycXBhK2UyRWp6bStBbU5pNnA2dkR6MFRuWFIxdXBNU3BNQzMzbjFD?=
 =?utf-8?B?bUNNV3ZtYXVVRVdhT0lXcHorZHdmYXQ0bFRxN0xOUXkwN203ZXRqTFgzN0Za?=
 =?utf-8?B?OVJQOVJpd0VGYVV5bWNINjVaMHhiU3NERm9UV3VPNmFoaHFLditDa0kxNmpU?=
 =?utf-8?B?eVp4cHhJTk91MnVZeWxQNjJGZjAyQ2RRM3kwRHdPS3E5SnlaOHFHY2g4SCt3?=
 =?utf-8?B?TG9scDRRekMwbzhsMnhQcGFFK0lQcis5L0lkTVVCN21QRjl1bWlacTV6blox?=
 =?utf-8?B?VzE5eHVqczZhanNUeHJpMFpSQjYrMDFXUTgvS1hHUVMybk1FOFNBU3EyK2Q3?=
 =?utf-8?B?MlNPMWwyRzZ3TVNzTTRhK0QxZmxndXFYZ3doKzJpd3RscHVLa0lzVGwzT1BK?=
 =?utf-8?B?dFlXcEp2UndmZGFRUzJZdHNZTDN5aGtGbXZvY1RjNkxHRVhLT1Btcmhkd1ZE?=
 =?utf-8?B?TlFFWVFuamppNEQ2d1AxTnRTTEdWajhYZm8raGNtelNldkdlZGNJU3hmZnZZ?=
 =?utf-8?Q?OxSbeuwUOqP3XQt37eO+eZxTx?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8691132-2432-4a81-39c8-08de3c7f7bac
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2025 08:45:36.8452 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UG6009pR+XLk+JEuECbQ5eab6cHnJZB8YPs9RkZM1ObsCeSgY8nVkUWKHmgQx6kB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7643
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

On 12/15/25 17:56, Philip Yang wrote:
> Add helper amdgpu_gtt_mgr_alloc/free_entries, define GART_ENTRY_WITOUT_BO_COLOR
> color for GART node not allocated with GTT bo, then amdgpu_gtt_mgr_recover skip
> those mm_node.
> 
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c | 48 +++++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h     |  6 +++
>  2 files changed, 54 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c
> index 895c1e4c6747..285177070895 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c
> @@ -26,6 +26,8 @@
>  
>  #include "amdgpu.h"
>  
> +#define GART_ENTRY_WITOUT_BO_COLOR	1
> +
>  static inline struct amdgpu_gtt_mgr *
>  to_gtt_mgr(struct ttm_resource_manager *man)
>  {
> @@ -180,6 +182,49 @@ static void amdgpu_gtt_mgr_del(struct ttm_resource_manager *man,
>  	kfree(node);
>  }
>  
> +/**
> + * amdgpu_gtt_mgr_alloc_entries - alloc GART entries without GTT bo
> + *
> + * @mgr: The GTT manager object
> + * @mm_node: The drm mm node to return the new allocation node information
> + * @num_pages: The number of pages for the new allocation
> + * @mode: The new allocation mode
> + *
> + * Helper to dynamic alloc GART entries to map memory not accociated with
> + * GTT BO, for example VRAM BO physical memory, remote physical memory.
> + */
> +int amdgpu_gtt_mgr_alloc_entries(struct amdgpu_gtt_mgr *mgr,
> +				 struct drm_mm_node *mm_node,
> +				 u64 num_pages,
> +				 enum drm_mm_insert_mode mode)
> +{
> +	struct amdgpu_device *adev = container_of(mgr, typeof(*adev), mman.gtt_mgr);
> +	int r;
> +
> +	spin_lock(&mgr->lock);
> +	r = drm_mm_insert_node_in_range(&mgr->mm, mm_node, num_pages,
> +					0, GART_ENTRY_WITOUT_BO_COLOR, 0,
> +					adev->gmc.gart_size >> PAGE_SHIFT,
> +					mode);
> +	spin_unlock(&mgr->lock);
> +	return r;
> +}
> +
> +/**
> + * amdgpu_gtt_mgr_free_entries - free GART entries not accocaited with GTT bo
> + *
> + * @mgr: The GTT manager object
> + * @mm_node: The drm mm node to free
> + */
> +void amdgpu_gtt_mgr_free_entries(struct amdgpu_gtt_mgr *mgr,
> +				 struct drm_mm_node *mm_node)
> +{
> +	spin_lock(&mgr->lock);
> +	if (drm_mm_node_allocated(mm_node))
> +		drm_mm_remove_node(mm_node);
> +	spin_unlock(&mgr->lock);
> +}
> +
>  /**
>   * amdgpu_gtt_mgr_recover - re-init gart
>   *
> @@ -196,6 +241,9 @@ void amdgpu_gtt_mgr_recover(struct amdgpu_gtt_mgr *mgr)
>  	adev = container_of(mgr, typeof(*adev), mman.gtt_mgr);
>  	spin_lock(&mgr->lock);
>  	drm_mm_for_each_node(mm_node, &mgr->mm) {
> +		if (mm_node->color == GART_ENTRY_WITOUT_BO_COLOR)
> +			continue;
> +
>  		node = container_of(mm_node, typeof(*node), mm_nodes[0]);
>  		amdgpu_ttm_recover_gart(node->base.bo);
>  	}
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> index 72488124aa59..25640bed7dc9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> @@ -141,6 +141,12 @@ void amdgpu_vram_mgr_fini(struct amdgpu_device *adev);
>  bool amdgpu_gtt_mgr_has_gart_addr(struct ttm_resource *mem);
>  void amdgpu_gtt_mgr_recover(struct amdgpu_gtt_mgr *mgr);
>  
> +int amdgpu_gtt_mgr_alloc_entries(struct amdgpu_gtt_mgr *mgr,
> +				 struct drm_mm_node *node,
> +				 u64 num_pages,
> +				 enum drm_mm_insert_mode mode);
> +void amdgpu_gtt_mgr_free_entries(struct amdgpu_gtt_mgr *mgr,
> +				 struct drm_mm_node *mm_node);
>  uint64_t amdgpu_preempt_mgr_usage(struct ttm_resource_manager *man);
>  
>  u64 amdgpu_vram_mgr_bo_visible_size(struct amdgpu_bo *bo);

