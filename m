Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A32AC7EE39
	for <amd-gfx@archiver.kernel.org>; Mon, 30 Jun 2025 08:53:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D641E10E3CA;
	Mon, 30 Jun 2025 08:53:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="V94mjDwz";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2046.outbound.protection.outlook.com [40.107.244.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6B7EE10E3CA
 for <amd-gfx@lists.freedesktop.org>; Mon, 30 Jun 2025 08:53:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EqfE5gK8g1rcwQfceOmXYe939nmFIZpJ0xAtFUYjt/lZJDVvJFQ2V6nJIpSAmW3UdMQyZBDWc3WkJlCszJiEbS/z2OwXLNQ8CcyNeXTKBI9TrvIUt9AGn2bj0AdybBQDhs17GTMaZaGYIAdar3yfjRxhcwCP/lSvixkjCCCABnXEgDRPaJ32MbIuSyie6aPrUsTwwQZnOsb3Mzl8qiJtKwxqrnDBkc1bhAP0JMNZT1pByqNKQLbOKrM/wa4nmTbg7sOAIoytlaAwphZ9h6rURXqRj0hfQOor7xsOmYfAF63xtASr/OBIO4ck6yBJSHomQiGyRDNnncoMHNb5eB5CXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0fgWbq98n0XZB7DCn3vSLFIvJrUcHp6bJS2O7tDdCR0=;
 b=MVdtjLWQ8+BCqTOAwVLTq1WFSg2P6KIaxVuSLVLBjbVGDW9aLVcNQjYt3m/xtFmQR+Z2sjMplI15IrjdlIDEtSS50WstxxTisiVjjmIa60KQHU8FShVTgBRUHo/K3A0COygWRRGYx7m3vbRIVFPWeHcYFE+RiprAJBYDM3n3gE4ve4w2lIDYQScLrzx1r6vuHiTa4C2GB8owNzF0K0AO7BIqkV8KAR2Ntmi6OEMxFNFOnbr5pKQaPIVVqZsAmyOFyJowOZBWwoHLCS7uLVG3WrfJqmCAJaoFwms7QBF/rAS1FXmzdQ6/db1PyH8ZN6BeLaGt6MzawUX1cTXLnozPMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0fgWbq98n0XZB7DCn3vSLFIvJrUcHp6bJS2O7tDdCR0=;
 b=V94mjDwzY/+74I1fg6abM0r0vagFqoVoTxYLn5RlVt50dhC2rK16pHpSqCks0U+FxCJpv1Gx02zwzdPpn233qJ+VN6lgXtMP9sj4923lB1ELE9DCqnSYVv3+iwWpa6UUU9exKTnatKMkhi1pzSvY3G2UV1Oe5PrS+kRkVsy1Uzk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CH1PR12MB9597.namprd12.prod.outlook.com (2603:10b6:610:2ae::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.23; Mon, 30 Jun
 2025 08:53:46 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%5]) with mapi id 15.20.8880.027; Mon, 30 Jun 2025
 08:53:46 +0000
Message-ID: <66c24051-906d-4dfd-bbac-897b395beccb@amd.com>
Date: Mon, 30 Jun 2025 10:53:42 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/33] drm/amdgpu/sdma5.2: clean up resume code
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org,
 sasundar@amd.com
References: <20250627034002.5590-1-alexander.deucher@amd.com>
 <20250627034002.5590-6-alexander.deucher@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20250627034002.5590-6-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL1PR13CA0407.namprd13.prod.outlook.com
 (2603:10b6:208:2c2::22) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CH1PR12MB9597:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c80fb30-8693-4edc-0ca2-08ddb7b39fa7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?elBBV29SeUZFOFBZMWt5TG9WK01xKzUrS3drRy9zU0NFVEk0bHRUQjhvN29w?=
 =?utf-8?B?UXNFcWFVWDZPOXZyc2dkV2YyWTRsYVl1VEt2b09xQmtjRGV1YTNQMFdib2c1?=
 =?utf-8?B?NEkzOUhKZlJuU3dRc3lIRkpsU1ZueDRidXJKY1IzelhFSDdUQllSZE0vUTcv?=
 =?utf-8?B?MWd4Q3BBdStvNWR2QkR2VHFpbkExZlc5eit1ZGlWQzVBWDBvenJObU9ZN0xN?=
 =?utf-8?B?Z3BQY1JPL2d6NzI0em0rNzZZZ1hFeHpWcy9YaDlaZUlndmp6RmRCdkV4WmtB?=
 =?utf-8?B?RXdVY05RRStlT0V5eFpCZTV4NTJwSTJMRUFGajVhTmJ0d09SMHZBSE03WmN5?=
 =?utf-8?B?UHh6aFhNVExvemdKcVNWQzcyR3A0TUZvSGcvQS9lZFpnT3dOeHpvRnhZMFBs?=
 =?utf-8?B?bkx5bzA0WnZ6UHFxR3JFL01wVXdpMFgwUDJ3cTA4SDBtZHRFVnB2L0pORGZ3?=
 =?utf-8?B?ZmNhMnRucmhUOUFMMURyYysxeTlMYUVYaGZIR2dFQ0VCMi9mNDhvTU9RV21O?=
 =?utf-8?B?UklvcTBxejFZbWN0R05uV0tnTkdHelp5WjBONVlZOVZCQ2RYTVZWdmIvVzBU?=
 =?utf-8?B?OHlHTGpMOEZGdnFINitRL29ZOGZiWCsvWTI0aC9IdGJyNE5VMFg3ODVvaVdZ?=
 =?utf-8?B?NHBQY21NWFd3L3VFdmthVnU1QU5rWGVlYUhWUEVqZkhiOWxZa0FsdzVtYjQ3?=
 =?utf-8?B?ckd4V2FCZUx0cjlhUlA1ZU8zTzRFRVJjQ1RCTVhwR1hMaU8rNjQ1NDEvTVJK?=
 =?utf-8?B?dS9vNEdMUEI3U2NJcjN0VmVoemZaWkVaVzhTQjZGMlNOYnhacVloTzUreVAw?=
 =?utf-8?B?bFZyWVh2d1ptNVl2OEZOeWlvclJvd2FhMDlvcXVNRVhWZnV1M3Z5WjJVQlh3?=
 =?utf-8?B?T2tLRVpaUjczU0hGUTlwTGU2bzltR3ZURWVrM0t4eUhiSk15REFwNUNqUi9H?=
 =?utf-8?B?YzlFTElxK25sVlZhVGZ6UnppamFOMVhYWmd1QVJwcmVHNkQ5a05hMDFsQ2JY?=
 =?utf-8?B?ZnpESmtLbHo5NzdvMDFrV2hOUTIzRlE5b3lkR1pra3lNazVIM3VpMHd0eVo5?=
 =?utf-8?B?NWxld0M0OXNhMjdEM3VGWlY2QjhQSkhyWmE2YmZKaGNVdmNoNDBHWlFLV3pW?=
 =?utf-8?B?bXBuM0U5cTZScHhtbVJkSlNycWJMZ0lqaU5xTDZpamFpQnRpbVNReFpuYkpp?=
 =?utf-8?B?VHFpNXBuQnAzM1g0c3V0KzByeStZblBtRmlhdjdzVEZTNk8rMzZNWmVNUWt6?=
 =?utf-8?B?SXFpd3VEQVlFTEtYQTN2NnozQ3hmSjRIdmZYSGI1Unphd0VneGR2VGtjKzg3?=
 =?utf-8?B?b3dyZWg2SHpGTXlIemZldmxlRHhyOUFKMDBUVm04dXFCSmdVNk9Xa0tCSkJJ?=
 =?utf-8?B?VEU0Y3orNmF0REFITlhCWkJNSURXeHJHNG9HYkZpanVhUUhqYmlsRytETVZR?=
 =?utf-8?B?eHR1VUIxTWtYSmJXcHdNYTNyWTlrMU1tTkxVRmU3YkR2VlBhM0ZHK0x3Qll1?=
 =?utf-8?B?RlR1bTdYNUJkQkhNR1ZPcGxXSlhnTVlHTFJSS0c4aUFFdFRVTHpwQ0YyMmFk?=
 =?utf-8?B?aWo5R245a0xrTzdDajMxMHkwc3RuYlVsN2JIWjg5T0NkbHR1RlU4ZG9rUHJv?=
 =?utf-8?B?MmlnbDM2MnorYzhJZFN1emM5cVpmNVFzcTNQVXVHaFpUcG5RYlBxb3F5SlVC?=
 =?utf-8?B?dCt2TWZLRHJ1VUhYWWhKWnl3enMrdmduUTlLbHdpZWROc2pGSUZ3U1F2ZVFH?=
 =?utf-8?B?eDVaUFJTbSszQk91dzk0MVlVakJtcmdvZzhZTHd2eTNEaVlWVWNZM2E1ckRj?=
 =?utf-8?B?WFo1OW92S3Q4M24rZ0dkc1kvZVRpdTFXb2tjeHFjWmpuWlYrNndwbVluSCtZ?=
 =?utf-8?B?K09vamg5eVlQTmN3WHlnYWlIK01NL045Nk9udTAvL2h1aC9rc1hTZnJmVk0y?=
 =?utf-8?Q?gK22jczEmdg=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UDlxM2NoT1ZPazJQaEtBSVFTc2I1Ylp5SnpTWVhOeWhNNFRuME12N2RSbm56?=
 =?utf-8?B?QVN0SlA2Z2VTM05Ba0Z2S1FhaGdleW02ZkttRnVsMncwVjRhYXJHVVNxRWQ0?=
 =?utf-8?B?MlZ3d1dJL1B3UmxNY3ZJcmJtT2FaYmptejVMNWJJSFppVm1KVlQrcW13M2NL?=
 =?utf-8?B?Z3NITkpFK0I0MDh2R0dmbi9DOE1VeGpGWDBZM1FWc3lvN3lOcUFicGY5eWpE?=
 =?utf-8?B?bEZJdjNVR2cvaHR2dUxqL0JCUlZyY3l2ZVRQRnJ1bmt2czRSUC9sazl3NElT?=
 =?utf-8?B?TDFMYmFrTG1qcndOa0dVMXMwblJLZ0cyLzI2ZmNEL1ZxYTJxblMzYmJkQU00?=
 =?utf-8?B?N0pVMWxmTGRBTWgvNUNnMG9nT09WK0JSNzdSdnhLNmNDb2hPMHNzVzhsQm5j?=
 =?utf-8?B?SE1BZ3pUYk5YTXdpTSs0WjNJb1BoRk5MYTdPbGJnc1FuZk02WFc1MWVYeE9H?=
 =?utf-8?B?blVlTXpNc0pMajNDOUVNenlVai9YaHhRNHZEL2tFUWNSY201cnQrdDFwSGpY?=
 =?utf-8?B?RU1wN2ZTZVZDdkNIVi9tZU5kN2NwcnRkbVFYSGF1WTBrejZVa2lVK2I5ZTlK?=
 =?utf-8?B?Vzg1R09XVHJ0Y2pIbzB3bkNQU0tOYk1lcTBzem1sUlA5K2RpYlFWTlNEOTVJ?=
 =?utf-8?B?ckxxaXk1S2JOa2UzNXIwRGtPL2FQU0hOdmk4c1J5eWVRM2V5N2gyclY0aVIy?=
 =?utf-8?B?dGlwYm1obUp3R05FZFRXeURRMUJrY3Iza0w0azBObUhhUTZsd2dYa1daelFR?=
 =?utf-8?B?Z2JXNjNUNXVFU2d6cjFMSkl6WEFMNHRRdmhKZEp1OFpISXJkb0xJaU12T0VI?=
 =?utf-8?B?NHFDQWVWcG9QN1hqTDFVVWUwLzJudktEbndhS3RNUVo1VHIzd01qTGtia1Bw?=
 =?utf-8?B?SHpPSXl2Z29FQmN6MDJ6OHlRU01uelA0WmdlelJCMFpOOHlZRWlJWmpxQjlK?=
 =?utf-8?B?bkFJQ2ZPNVBuZGVlWVNRc1I2enVCYTNUdVExc0VwZlZMcW1qaFArTWVIY1ZC?=
 =?utf-8?B?amRGWWk0dFAwL0R4dDdHc3kycjh0RFRtdmZxMWhyd0pMcy9pVmRCRXYyeGkv?=
 =?utf-8?B?UW4ybTZNWU5qbTg0dHhpWUZvMEovZnlmUlZkMTBod2ZGSXA0QzZ6Umc1dVRi?=
 =?utf-8?B?eE1La1haTDdMUmw3MUNjOFZGUmhIdC81YjJhL2JWMlBicWlCV0lsaFkwUUdo?=
 =?utf-8?B?R1g2UzFJL3BBYmw5Tm1ERnljVnRJa2kvdkFyOW8zcUpqT1pFa3ZKZFR4Q25M?=
 =?utf-8?B?dnJBaDI1SWFMcTNvdEhMQ2I2STdiSVRwbXZRdW9FQ2lZVklucHZGSE05RjMz?=
 =?utf-8?B?L3h3ekRBR3g3Q1ZDK0JsaWpKNGZMMFg3V2ZwQmxaK3JQN2hON3ZNVFR4VFNI?=
 =?utf-8?B?bjU4Q0srVkllUStoNkEyRzJpMmt2alp1TnlsdUZEZkYyZ0xINHZLQUZwQjBm?=
 =?utf-8?B?UDY5RVBqMm5CZW1ubkk5MUl1TUFBUHpxSjJoSEg0MDhweC9DT1lZVFdjRnNG?=
 =?utf-8?B?U2oxS2pGOUozZjVGL0lGSkZDSDFtb0JUZWRhWWxvSUpiRXNzUHdENFlOaUJs?=
 =?utf-8?B?VjVId0VwRklkbGp5b3RSUUpNR0crcGFoVDEyc2RyQ0xIaXluMXlDRW8zZmF4?=
 =?utf-8?B?ZmdzYjJqNGpwZUFpMWxEWmxtNm84Q29EaU04c3AwMHZnRTlLOTc3L3o0UHhx?=
 =?utf-8?B?cWx3NE1qTUNaUjBjai9zL24zY01FUzVnc2pKejhlMEN4clJLM052T0xud0tz?=
 =?utf-8?B?QW5qUzBtQ2ZaMnNaaXZBZGY4UFpwSlRjbVZqOENYZUI2eHRlYzQ2OWllUExK?=
 =?utf-8?B?V09YaFFxOGhTYkdRTGhnOHRZc3ZicjJrWFR4d21oV0pxM3p6ckViSFBQS3VM?=
 =?utf-8?B?eWtnY0ZST3ZEa2tFZ1hVdUV2YXBhN2RvOUpLS05hanQ0YUVJR1AvZkdrVWhB?=
 =?utf-8?B?cXB6bEhLd2d0ejN2bkNaVExXSEhZWk95QWlBZzM1TkYwU0FPaWlMdGxlRUxh?=
 =?utf-8?B?Wkd6SXJ2cmdsUDBXdnRESjdPeFBzVVkzMzc5Vnd0bkJLbTRIbVlnNm1ab0Vh?=
 =?utf-8?B?QTdrZ2Q2MUExR1QvU3RQT2VEd1FJOXd6TVdSKzd3WWJTc2R5L1hzbzRicHNa?=
 =?utf-8?Q?ArhAWOio3QVHHQzmXEOCYB6T0?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c80fb30-8693-4edc-0ca2-08ddb7b39fa7
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2025 08:53:46.3829 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dIqidwl1VJddM/7gE7UgbZ1nZwdx0NVxB1Z+xYiAkgrPkHgdFzxVu6QGzboEdnAw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR12MB9597
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

On 27.06.25 05:39, Alex Deucher wrote:
> There no need to save the ring ptrs.  Just reset them.
> This cleans up a conditional in the resume code.
> 
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Acked-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c | 27 +++++++++-----------------
>  1 file changed, 9 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> index 6843c2c3d71f5..b9498697ef41c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> @@ -528,13 +528,12 @@ static void sdma_v5_2_enable(struct amdgpu_device *adev, bool enable)
>   *
>   * @adev: amdgpu_device pointer
>   * @i: instance
> - * @restore: used to restore wptr when restart
>   *
> - * Set up the gfx DMA ring buffers and enable them. On restart, we will restore wptr and rptr.
> + * Set up the gfx DMA ring buffers and enable them.
>   * Return 0 for success.
>   */
>  
> -static int sdma_v5_2_gfx_resume_instance(struct amdgpu_device *adev, int i, bool restore)
> +static int sdma_v5_2_gfx_resume_instance(struct amdgpu_device *adev, int i)
>  {
>  	struct amdgpu_ring *ring;
>  	u32 rb_cntl, ib_cntl;
> @@ -562,17 +561,10 @@ static int sdma_v5_2_gfx_resume_instance(struct amdgpu_device *adev, int i, bool
>  	WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_RB_CNTL), rb_cntl);
>  
>  	/* Initialize the ring buffer's read and write pointers */
> -	if (restore) {
> -		WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_RB_RPTR), lower_32_bits(ring->wptr << 2));
> -		WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_RB_RPTR_HI), upper_32_bits(ring->wptr << 2));
> -		WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_RB_WPTR), lower_32_bits(ring->wptr << 2));
> -		WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_RB_WPTR_HI), upper_32_bits(ring->wptr << 2));
> -	} else {
> -		WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_RB_RPTR), 0);
> -		WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_RB_RPTR_HI), 0);
> -		WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_RB_WPTR), 0);
> -		WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_RB_WPTR_HI), 0);
> -	}
> +	WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_RB_RPTR), 0);
> +	WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_RB_RPTR_HI), 0);
> +	WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_RB_WPTR), 0);
> +	WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_RB_WPTR_HI), 0);
>  
>  	/* setup the wptr shadow polling */
>  	wptr_gpu_addr = ring->wptr_gpu_addr;
> @@ -599,8 +591,7 @@ static int sdma_v5_2_gfx_resume_instance(struct amdgpu_device *adev, int i, bool
>  	WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_RB_BASE), ring->gpu_addr >> 8);
>  	WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_RB_BASE_HI), ring->gpu_addr >> 40);
>  
> -	if (!restore)
> -		ring->wptr = 0;
> +	ring->wptr = 0;
>  
>  	/* before programing wptr to a less value, need set minor_ptr_update first */
>  	WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_MINOR_PTR_UPDATE), 1);
> @@ -698,7 +689,7 @@ static int sdma_v5_2_gfx_resume(struct amdgpu_device *adev)
>  	int i, r;
>  
>  	for (i = 0; i < adev->sdma.num_instances; i++) {
> -		r = sdma_v5_2_gfx_resume_instance(adev, i, false);
> +		r = sdma_v5_2_gfx_resume_instance(adev, i);
>  		if (r)
>  			return r;
>  	}
> @@ -1531,7 +1522,7 @@ static int sdma_v5_2_restore_queue(struct amdgpu_ring *ring)
>  	freeze = REG_SET_FIELD(freeze, SDMA0_FREEZE, FREEZE, 0);
>  	WREG32(sdma_v5_2_get_reg_offset(adev, inst_id, mmSDMA0_FREEZE), freeze);
>  
> -	r = sdma_v5_2_gfx_resume_instance(adev, inst_id, true);
> +	r = sdma_v5_2_gfx_resume_instance(adev, inst_id);
>  
>  	amdgpu_gfx_rlc_exit_safe_mode(adev, 0);
>  

