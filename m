Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17451D12D7A
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Dec 2025 16:06:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A38F110E7D8;
	Wed,  3 Dec 2025 16:06:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="k5n5nP9u";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010010.outbound.protection.outlook.com [52.101.56.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DD07310E7D8
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Dec 2025 16:06:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qPldtObrF6had7UrUchMIkWdCux2H+0r15EXJIYDcaCA8Vui9cM/2rg9wxZbAHeD80KxLRum9UIQ2ck303ow3NeARMyJ0mVqZ1xlU7+RSYpaRShwt4XW2NabojR0U1EQ28XYI5aYWaAgO45TYgf/R16oEifRLGgz1M9PEoHLUBBLkGhBwbVl0+tdEj7D5xj7x1bz3FqIhlOlnU8cP8L9spe68J5hiegU5+rbGpZP655oa7SbrWgBhL/8OeIT+CtrOIbDN/vQUa8fsLVgJ4jalOUk/cIvsPAem4dbX79WLtHONTXSFG93iR3G2nZUyrSAzVDcUdHDaIowkH3p/NhBNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vnM7fyoADrV7yriO4EATYrOXtj67p4P1APByp9E0lPs=;
 b=eU3ebrKQ5pLnA1Ik8M6S8DK0tlY3mj+a+aqyHRj1qbZzYdoYC7tEkuJ9bqMAQq3bjdIk0clD9ODGY7NUKlAlehk/vfbTjFgGw8sgDXHz/RXPJGUMbEbOqFpA8OB5FDFIpmZKeUMrhzb1vo7AQQz/HyP+Kon4UTyrgVBOrZzv/QV+/FAJZbscGPr0YQwvf5WOpkSbtXeuZfy1i0KI8JRCE0mrpRekemEdzWwz9LGLawAUIKGl6HiwZRhtnZLB4FR+pb66LwSMZ7SP4BG4AgPmF6zrms425LuZvus1F+OmiQdDYpkXnLw2cDecczjrsXWLf2FUQkBT2wJBpkrfNJkOLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vnM7fyoADrV7yriO4EATYrOXtj67p4P1APByp9E0lPs=;
 b=k5n5nP9uWsI3/9RgAwiIRmb7b6gdGzXUswlz8l74ngld+JxZ2pI2dSai43ci7aaZI2rWFhWf3eqkWHw63GvGsfS9Q2AbFoDCrazp9gpSSzoE/tlFf78x3AU69hMGBjYjGZSiTtHdNLm5/vzV+c+c0lpUvqIWwwHR6BY06NaK37c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DS0PR12MB7876.namprd12.prod.outlook.com (2603:10b6:8:148::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Wed, 3 Dec
 2025 16:06:18 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%4]) with mapi id 15.20.9388.003; Wed, 3 Dec 2025
 16:06:16 +0000
Message-ID: <ba907ce9-8a80-4aa7-8d41-11880b56c0c0@amd.com>
Date: Wed, 3 Dec 2025 17:06:13 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] drm/amdkfd: Map VRAM MQD on GART
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Felix.Kuehling@amd.com, david.yatsin@amd.com
References: <20251201142838.1516452-1-Philip.Yang@amd.com>
 <20251201142838.1516452-5-Philip.Yang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20251201142838.1516452-5-Philip.Yang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0392.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cf::17) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DS0PR12MB7876:EE_
X-MS-Office365-Filtering-Correlation-Id: 2245af4a-d740-42f9-b902-08de3285e390
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WTBtKzFCRFVhSHhLYW9vUlVQOWtHRHhoU3FVM3UyMTdVNHVpaE1KNTI5cERm?=
 =?utf-8?B?MjFhbXhHem1scWxta3prdUpWSlZYVGw3SXN6SGhwU21NNGZSNE1vVjExZTZl?=
 =?utf-8?B?cWdqMExtK0xTSlVSR0pPR1krUUVlNm9zOW1ad2lSTStmV28zUjNZY2FBbEd0?=
 =?utf-8?B?b0E1WDBFRkdXenZyR2svcnN4ZkxlOGJvQ0xYL1lDTFd0TFpvRXovVVBpeDBF?=
 =?utf-8?B?cnVlN0VZRDhRazhGdkZlTmI5cXl6emhvTmRKT0Rsb1lzcDBHTHVOM1dhdFNr?=
 =?utf-8?B?ZUh4ZmZaY3NRRStkbHgybTNLZ0ZwQThVcUdTOEhkeUNKMk9FZmJRWTJwK0sv?=
 =?utf-8?B?eTJvTUIzUm91Sk1NcnhDYUJGNW1vNVlFRFVJOTZ1YWs0SWhuRHpPb0JDa2ZU?=
 =?utf-8?B?dHd1T1YvRnBtQWs5R2d5R255amgvcHFveTZPUU9BUUpIRG84RW94TTFUT21t?=
 =?utf-8?B?NG1mNmFBWTVtc3I1SW9lYmFpS1I2R2J1Y3dYamZSV2xRZXhwdjA5NEtzK2NC?=
 =?utf-8?B?K1c5T1ZVUDBaREVsR0JsNnZRTGNRWGl6R0tGQjZnV3lTSEFGS0VsV3BBbE1l?=
 =?utf-8?B?dDBZNlB6K1pqem9xYlRtd0YzM1JjUm1QM3IwZ2RyeXphbGNKNkdYSGJjL1hG?=
 =?utf-8?B?bE1uMHFZT3ZJUmhOblRlakVZNjg0SERVMWVOc3Roc1RscG9aQkZLalRCcUQ0?=
 =?utf-8?B?WXh5bENCcG5MVGMyUXFrNXlWL0t1cU5vejl2bVVsd3ZaN2RMTGVtTU5ZOXRR?=
 =?utf-8?B?WCtLMWJjdjBsUXV3L3JCcG1EcGxoUFpYS2xFMlZKbTNSckhMd1JzMURiNFYy?=
 =?utf-8?B?SkJ1SVIwWS9QSHFUNjE0bnVOc0hPdmhmb09xUlFKTHFnWG5uSzJjWDc1SnpC?=
 =?utf-8?B?SVBrRmhlTUpJR04yNkR6ZjY3ZmZkRUE3Q0V5TzZxRFVWZzFtMThpTE9BMFYx?=
 =?utf-8?B?N1ZPRWlKdVU3UHBTN3AxZHlUZkFWNm1qQ1IzMXRVTmNlVTA3dEVzamY5M2kw?=
 =?utf-8?B?ZWF2c0h4T3pLMmNvTzlORE9Eb3JuZXBDMWVHRlhTOTA1VUxvSnd6MVZMU0lJ?=
 =?utf-8?B?dnVlaTFNcXVVb1kxTVh1aGhrcXppMkZKdUYxSE43akU1MVlIY0pBNnNKRGFY?=
 =?utf-8?B?WW4rSzVuN3ZzTjlEQmx1YzVGenVZeUN6N1RveU84VFNZa2ZEdjlzemF3am1h?=
 =?utf-8?B?VE5zUkFsS3dXOExNeWhFYi9PUEpQaFRRbFFOUjlWdDBpcWd4MWIzdW9ieUpZ?=
 =?utf-8?B?eHBMVW4vOFl5ZW9qa095Ky9xUWZBSWtoN3ljNDNrSDI0cTJhUEVJTlo5RGFB?=
 =?utf-8?B?TG9KNEpNTjN3eVcxTGVXVnpJTlkwQ3UxZEFkSWJ1QzAyVSt2bWdiSXRhV2tU?=
 =?utf-8?B?UkhHcXdrVE5NRE5EVVhxaXNiMUFWWE1iMm1EUUZIUWVqcGNIbEN6V3hPMVFQ?=
 =?utf-8?B?R0ltSFFVOURYbFhJbnRvenlTSDBHNkhQbDVZR1JKSEJOVXRxS3FtUldhbnJq?=
 =?utf-8?B?dXJkakhvRDhnUUdWdjk1dVhkUkUrZlNkMjI4WmQ0dDlyQUxrWTNLRmZIZUc3?=
 =?utf-8?B?WFB6ajdxdFAyMjJ4aEFmaVUvNkM1dk0rZnI3Z0dzV1pJKzF3eGN2U2lzenRM?=
 =?utf-8?B?d1MyZm56cWtjWGU0ZTUxSGV2VEVsWVZ4Q21hQW1GZTliYU81QmxTc0xQSXpW?=
 =?utf-8?B?LzV6ejlwZXRRZ0FhWEU5VXd2YXpoTTBsUnRFVG9HSWtDS3RQMXYweGs3RUVk?=
 =?utf-8?B?UmFaaVhKZStvM05xSkdtNzk5MnY1UDNKYjhZbUE0eStSdjhuWm1zV3FMeXRN?=
 =?utf-8?B?RTgveHFOYUkzZmN5UGprUmlWOEFiM2tWMU03VXdXTXErYnNVQmRzODJhUDV1?=
 =?utf-8?B?cHhmNzhocVo4VVpFNEJCUnVyVFJNSnVGSDZkTUFCd3U5Tklpd0xXZGdIQlBi?=
 =?utf-8?Q?CJPkwCw+qZKEwE397lLMFwWxCEhOZR0M?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aXhPNGhUZEJvQktKSGE1TVN1NElYWmw1RmtoeUJtdFdxeHp4R25sV1MzWmht?=
 =?utf-8?B?V2ZTLzZTbWkwWWVHcC9wRWw5YXdQSG1TMjlDd3p3UGM3MnprRlZ5MlZCcnFq?=
 =?utf-8?B?eVZIR2tZYWhBa25QNU50aGYwcnZtdWZ1WlBDT2lYZkZtd1Z5WHQvdXcyMzVM?=
 =?utf-8?B?ZTRJMGJnZUxHVi9ZSExlUFd0bUtZWFUzT1QyMlZyMWdIck1LbzdCQlZoOCsy?=
 =?utf-8?B?SXYwdXdzdDVuZEhYZFpLSkZxTnFGOTQxelliL1N5emhwdmJGNS9JMGRBSzdC?=
 =?utf-8?B?MEQ4cUNlak9lajlkRWgvQjRFcnRWQk9IcEZzUm92R2ovdmhTdWs4YnNPUHli?=
 =?utf-8?B?YUtoM0tpVTJFVythQUIrMkkvR2UvSHYxVDN3WGRzL3czMDhic2o0cHJNdDQz?=
 =?utf-8?B?Q1prR05RT09GaEtOdE9OWVNVSHg0ZlV2ampiM0Z0L1pvaVZ3cXFnVFVyWmF0?=
 =?utf-8?B?bXUrTjJGWDNLTysvU21JalpVaUxPRW1MNmdtUWNjWldOZEIvdGU5VFFMMzZ1?=
 =?utf-8?B?dWFUMFdBUHpVVHFvUWFvenZHcUxKWkpaK2hOSzRKY1hsM05tZndQbTltOTRV?=
 =?utf-8?B?UThTb0RPSFBsbTgwUzZnaG83K2VKYTRCOWY2SEdOanVnQkVVd29TbDhXVm4w?=
 =?utf-8?B?MEtORmZuNGtNYkMydGp0bUt1SmtnbDBBZUt2MGVLQVN2MUduQ2I3UWlGb0pu?=
 =?utf-8?B?ckhUYzVKenU3RGVSSUNOdFRNN05YaXpzeHdrUzJyZUk0QzlYRGw4UHdaaW8w?=
 =?utf-8?B?U0ttT3NkVnk1ZkE1MFo3TlJraW1pV2pRZUZGY1lNT2VuWWs2UGFNTmVINGVn?=
 =?utf-8?B?UCtjd0Y1TCtVdTVmZWxuZzV5L1JsRHppaWtiL0pTL1RMcklvQVIvNlBzOVFH?=
 =?utf-8?B?QnZPTUFvYmpwRnB5OXV0QnJta0E4M3o5ZXFsajJ4WU9qOVI1RFJnK3dlU2NJ?=
 =?utf-8?B?b054bGtzUTVPZ2dnTkdXOXc2a25aTjEwNkZFQWFLQnZVTGwxMm9MTjFJTkhL?=
 =?utf-8?B?bUtGWWl4QXppMmViU25BaER3a2pHaVIxbFRQZzliY2pmekxsRXk5OVNqRGZs?=
 =?utf-8?B?aU9Nb08rSVV3R0Z1Tmd1ZWZnM1dmYjNqdkw0ZmVTa2dHWFh0aU9xc0p3VTdW?=
 =?utf-8?B?VmgvWm04b05BN3dIa0F4eHNDYUN3OURVMDQyRjJ0MUhHNkRoM2RNY0RDdnI4?=
 =?utf-8?B?ZVpJdzFMSjV6R1dmVHZLb25vUENSUCtTYUUrZHZ0bjhjWk1YQ24rOURoYzZG?=
 =?utf-8?B?RnZJc1ljWlE1NEs5eklJWWRMMTNhendINnFyRTA4anB4RHZpUytzdjNtQktY?=
 =?utf-8?B?OXVvYjhRUzF5NCtDUjRoeFJKY0R3dEg3cWhMQlpGYXFnSkJISU1zRFk2RHpj?=
 =?utf-8?B?d2lteWQ5NVdEd0N4cGhHUGVzR2RnOFVpellnNW45ejNEV0FRbmpSVm9ldjhT?=
 =?utf-8?B?Z3pDbFk0VURtV2oxdjQ5SUxXV1FKTWI2T1JoU1R6NEdhL0NGeGdkcWFndllF?=
 =?utf-8?B?d3k4eG8xM3hWSkxOTGlYVERTdlJnMHc0MGQvSkFtaC9kWW5CY01HQStEOTE1?=
 =?utf-8?B?ZDJWbEk4R1VnOEJuTlBURmJVOWNwSkZPMzJsaVh1VkZoUGcvTnltSVpGKzFz?=
 =?utf-8?B?L2VOczBzcC9XUmxvUC8xbU9BN2tWdHVuZlcvWk85UlRpSWg1ZXNaaVFteWpB?=
 =?utf-8?B?OGwwb1Q2UCthUVNXa3RrL0w4NnoyN01ybEdWcmVvaGpEMUxaSTA1NmtBK3lG?=
 =?utf-8?B?ZkR5bzVUTXllZk5iclJJa3lwUEVMc1VDOXgvMmpNUWV5eEdKTURhN1dLS3ZC?=
 =?utf-8?B?ZmNuYUUyU2JFR043QkNtSVBIYmprVk5UempidkkyWmlmVGpncmYrQ2dpTHVD?=
 =?utf-8?B?L2hMcC9JbkFVN2pGaFF0NEg2RlhPb3EySDRkT0RyN0hCMGdoM0wwRGhUM0pq?=
 =?utf-8?B?SXRkTEt4OWdqRGlZYTJ0L1NyNmw2cTFXNVpIMnVRR1dwcDR0QTRjczIrYUJp?=
 =?utf-8?B?OGV5cGpWbjU2OEoxVTdHRjN6Z3BXV2lvSWZSNHNwbGs4b0g4ZFkrTnVENFZE?=
 =?utf-8?B?TXJRNWJKYit3Rnp4R1gveExCS2lQV3czSHNGV0t1VkFpR0N3SXorTDU4Q3pF?=
 =?utf-8?Q?P2fJ7WC38qYHJf2cSW5ykao7b?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2245af4a-d740-42f9-b902-08de3285e390
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2025 16:06:16.6063 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0yn4Zjd6WkpIBv+CKuysBKZCMD4oPSi5MI7BtvCe+Htfa9GDNB/ZDA7mbKL2ZYSD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7876
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

On 12/1/25 15:28, Philip Yang wrote:
> MQD BO on VRAM access via FB aperture is mtype UC uncaching, map to GART
> as mtype RW caching, to reduce queue switch latency.
> 
> TTM bo only has one resource, add GART resource to amdgpu_bo in order to
> support dynamic GART resource and VRAM BO resource.
> 
> Update amdgpu_ttm_gart_bind_gfx9_mqd to map MQD in system or VRAM.
> 
> Add helper amdgpu_ttm_alloc_gart_for_vram_bo to alloc GART entries resource
> for MQD bo->gart_res and bind to GART mapping.

Clear NAK to that approach! That would completely confuse TTM.

We need to talk about that on the weekly meeting first.

Regards,
Christian.

> 
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_object.c    |   3 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_object.h    |   1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c       | 113 +++++++++++++++---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h       |   1 +
>  .../gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c   |   8 ++
>  5 files changed, 108 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> index 926a3f09a776..d267456cd181 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> @@ -1297,6 +1297,9 @@ void amdgpu_bo_release_notify(struct ttm_buffer_object *bo)
>  
>  	abo = ttm_to_amdgpu_bo(bo);
>  
> +	if (abo->gart_res)
> +		ttm_resource_free(bo, &abo->gart_res);
> +
>  	WARN_ON(abo->vm_bo);
>  
>  	if (abo->kfd_bo)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> index 52c2d1731aab..a412f5ec2a09 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> @@ -106,6 +106,7 @@ struct amdgpu_bo {
>  	struct ttm_place		placements[AMDGPU_BO_MAX_PLACEMENTS];
>  	struct ttm_placement		placement;
>  	struct ttm_buffer_object	tbo;
> +	struct ttm_resource		*gart_res;
>  	struct ttm_bo_kmap_obj		kmap;
>  	u64				flags;
>  	/* per VM structure for page tables and with virtual addresses */
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> index 5f58cff2c28b..1d8f5fc66acc 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -832,14 +832,27 @@ static void amdgpu_ttm_tt_unpin_userptr(struct ttm_device *bdev,
>   * Ctrl stack and modify their memory type to NC.
>   */
>  static void amdgpu_ttm_gart_bind_gfx9_mqd(struct amdgpu_device *adev,
> -				struct ttm_tt *ttm, uint64_t flags)
> +				struct ttm_buffer_object *tbo,
> +				uint64_t flags)
>  {
> +	struct amdgpu_bo *abo = ttm_to_amdgpu_bo(tbo);
> +	struct ttm_tt *ttm = tbo->ttm;
>  	struct amdgpu_ttm_tt *gtt = (void *)ttm;
> -	uint64_t total_pages = ttm->num_pages;
> +	uint64_t total_pages;
>  	int num_xcc = max(1U, adev->gfx.num_xcc_per_xcp);
>  	uint64_t page_idx, pages_per_xcc;
> -	int i;
>  	uint64_t ctrl_flags = AMDGPU_PTE_MTYPE_VG10(flags, AMDGPU_MTYPE_NC);
> +	int i;
> +
> +	if (!ttm && !abo->gart_res)
> +		return;
> +
> +	if (ttm) {
> +		total_pages = ttm->num_pages;
> +	} else {
> +		WARN_ON_ONCE(abo->gart_res->size != tbo->resource->size);
> +		total_pages = (abo->gart_res->size) >> PAGE_SHIFT;
> +	}
>  
>  	flags = AMDGPU_PTE_MTYPE_VG10(flags, AMDGPU_MTYPE_RW);
>  
> @@ -847,19 +860,33 @@ static void amdgpu_ttm_gart_bind_gfx9_mqd(struct amdgpu_device *adev,
>  	do_div(pages_per_xcc, num_xcc);
>  
>  	for (i = 0, page_idx = 0; i < num_xcc; i++, page_idx += pages_per_xcc) {
> -		/* MQD page: use default flags */
> -		amdgpu_gart_bind(adev,
> -				gtt->offset + (page_idx << PAGE_SHIFT),
> -				1, &gtt->ttm.dma_address[page_idx], flags);
> -		/*
> -		 * Ctrl pages - modify the memory type to NC (ctrl_flags) from
> -		 * the second page of the BO onward.
> -		 */
> -		amdgpu_gart_bind(adev,
> -				gtt->offset + ((page_idx + 1) << PAGE_SHIFT),
> -				pages_per_xcc - 1,
> -				&gtt->ttm.dma_address[page_idx + 1],
> -				ctrl_flags);
> +		if (ttm) {
> +			/* MQD page: use default flags */
> +			amdgpu_gart_bind(adev,
> +					gtt->offset + (page_idx << PAGE_SHIFT),
> +					1, &gtt->ttm.dma_address[page_idx], flags);
> +			/*
> +			 * Ctrl pages - modify the memory type to NC (ctrl_flags) from
> +			 * the second page of the BO onward.
> +			 */
> +			amdgpu_gart_bind(adev,
> +					gtt->offset + ((page_idx + 1) << PAGE_SHIFT),
> +					pages_per_xcc - 1,
> +					&gtt->ttm.dma_address[page_idx + 1],
> +					ctrl_flags);
> +		} else {
> +			u64 pa = (tbo->resource->start + page_idx) << PAGE_SHIFT;
> +			u64 start_page = abo->gart_res->start + page_idx;
> +
> +			pa += adev->vm_manager.vram_base_offset;
> +			amdgpu_gart_map_vram_range(adev, pa, start_page, 1,
> +						   flags, NULL);
> +
> +			amdgpu_gart_map_vram_range(adev, pa + PAGE_SIZE,
> +						   start_page + 1,
> +						   pages_per_xcc - 1,
> +						   ctrl_flags, NULL);
> +		}
>  	}
>  }
>  
> @@ -875,12 +902,14 @@ static void amdgpu_ttm_gart_bind(struct amdgpu_device *adev,
>  		flags |= AMDGPU_PTE_TMZ;
>  
>  	if (abo->flags & AMDGPU_GEM_CREATE_CP_MQD_GFX9) {
> -		amdgpu_ttm_gart_bind_gfx9_mqd(adev, ttm, flags);
> +		amdgpu_ttm_gart_bind_gfx9_mqd(adev, tbo, flags);
>  	} else {
>  		amdgpu_gart_bind(adev, gtt->offset, ttm->num_pages,
>  				 gtt->ttm.dma_address, flags);
>  	}
> -	gtt->bound = true;
> +
> +	if (ttm)
> +		gtt->bound = true;
>  }
>  
>  /*
> @@ -1000,6 +1029,54 @@ int amdgpu_ttm_alloc_gart(struct ttm_buffer_object *bo)
>  	return 0;
>  }
>  
> +int amdgpu_ttm_alloc_gart_vram_bo(struct amdgpu_bo *abo,
> +				  u64 *gpu_addr)
> +{
> +	struct ttm_buffer_object *bo = &abo->tbo;
> +	struct amdgpu_device *adev = amdgpu_ttm_adev(bo->bdev);
> +	struct ttm_operation_ctx ctx = { false, false };
> +	struct ttm_placement placement;
> +	struct ttm_place placements;
> +	struct ttm_resource *res;
> +	uint64_t flags;
> +	int r;
> +
> +	/* Only for valid VRAM bo resource */
> +	if (bo->resource->start == AMDGPU_BO_INVALID_OFFSET)
> +		return 0;
> +
> +	r = amdgpu_bo_reserve(abo, false);
> +	if (unlikely(r))
> +		return r;
> +
> +	/* allocate GART space */
> +	placement.num_placement = 1;
> +	placement.placement = &placements;
> +	placements.fpfn = 0;
> +	placements.lpfn = adev->gmc.gart_size >> PAGE_SHIFT;
> +	placements.mem_type = TTM_PL_TT;
> +	placements.flags = bo->resource->placement;
> +
> +	r = ttm_bo_mem_space(bo, &placement, &res, &ctx);
> +	if (unlikely(r))
> +		goto out_unreserve;
> +
> +	/* compute PTE flags for this buffer object */
> +	flags = amdgpu_ttm_tt_pte_flags(adev, NULL, bo->resource);
> +
> +	/* Bind VRAM pages */
> +	abo->gart_res = res;
> +
> +	amdgpu_ttm_gart_bind(adev, bo, flags);
> +	amdgpu_gart_invalidate_tlb(adev);
> +
> +	*gpu_addr = res->start << PAGE_SHIFT;
> +
> +out_unreserve:
> +	amdgpu_bo_unreserve(abo);
> +	return r;
> +}
> +
>  /*
>   * amdgpu_ttm_recover_gart - Rebind GTT pages
>   *
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> index 15e659575087..707654732759 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> @@ -179,6 +179,7 @@ int amdgpu_fill_buffer(struct amdgpu_bo *bo,
>  			u64 k_job_id);
>  
>  int amdgpu_ttm_alloc_gart(struct ttm_buffer_object *bo);
> +int amdgpu_ttm_alloc_gart_vram_bo(struct amdgpu_bo *abo, u64 *gpu_addr);
>  void amdgpu_ttm_recover_gart(struct ttm_buffer_object *tbo);
>  uint64_t amdgpu_ttm_domain_start(struct amdgpu_device *adev, uint32_t type);
>  
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
> index c6945c842267..d96de02c6bb9 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
> @@ -148,6 +148,14 @@ static struct kfd_mem_obj *allocate_mqd(struct kfd_node *node,
>  			kfree(mqd_mem_obj);
>  			return NULL;
>  		}
> +
> +		retval = amdgpu_ttm_alloc_gart_vram_bo(mqd_mem_obj->gtt_mem,
> +						       &(mqd_mem_obj->gpu_addr));
> +		if (retval) {
> +			amdgpu_amdkfd_free_gtt_mem(node->adev, &(mqd_mem_obj->gtt_mem));
> +			kfree(mqd_mem_obj);
> +			return NULL;
> +		}
>  	} else {
>  		retval = kfd_gtt_sa_allocate(node, sizeof(struct v9_mqd),
>  				&mqd_mem_obj);

