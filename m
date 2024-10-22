Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98C66D2C552
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Oct 2024 13:46:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4CF4D10E19F;
	Tue, 22 Oct 2024 13:46:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4LUEQpiz";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2064.outbound.protection.outlook.com [40.107.243.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3FEA010E19F
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Oct 2024 13:46:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DWLCFgExWnEoFxCru5gJCJD2DCB8SLGEUSk0VeiF/mTWL79/Mukv++WOiQAC27Y9OAY8LAqj+yEze+cruu05QaAe9+S+1v3FA4cAURWtnNyWRVml5gaVZRSRwVob91AmNYksxT4YLRIYKDLrW6SfuJ7KPnZxEot8HVW6draZ3DEXmzJI8HP/9FCDs56eVTZe+GZBr2YQu7t7dYSIERdJhkCs28cA0W38ULrRAeoQL9hmIKZ7pn0fZObEcXJ0ktyuvp6qqcOWybVsUblpt/QSCGrchrVhzPZmKSP/WnQ+1OsXZl6NlFews6rNnRBcuHTgNtwIYEyaDnsz9xu8TaaNeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Po6OdeW/U5t7lbYnO/yyj0y44r75ETG3ZpX589qKKiA=;
 b=aQFTmVS4H+5HPC4V2yM95Efx5meF5Oq6puFlllsnntjK1aOSu8BBM3dyEoLj0x3Nnd8+TJda23mS4GhdJRjE4b3UU06zDz5DtEN0RL0hFwhodFgsj8ZtzRbl82H2zNaBrGqp2DWVbZv8Tbf6It0/cxBRfhoPKoEStXwFAfD/mK9MmgdZhlBGeYXysnmwN/4d1c/U+p1nmdZVIF02QT8gVyUazUVG8oy43yLVx69LBH1CBuMDjwG5USWhUYEV5CbfSA/WbndUhMnVoAUtpBz8GaEiW6kSrcf25F+bD43PtKO+BGPhE+Tx1AyalBaXkDHyLJ8Zq1wjud7Jumaojewp9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Po6OdeW/U5t7lbYnO/yyj0y44r75ETG3ZpX589qKKiA=;
 b=4LUEQpizIM0wD8cWpcdwUY0w5D+gJ95qP+fsSR2k2bZjRFdDEtC9dieo/xUSdThIf92cX0YttqIHXJ1E1SOpaEMBCugeaunCseYuMnzsoMe1lLGj6IFPxaqxOGPybV4p9665aRFxUl5UmgB5l+W8OLltraKxqoE8r6uAY20VZYQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by DM4PR12MB7502.namprd12.prod.outlook.com (2603:10b6:8:112::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.16; Tue, 22 Oct
 2024 13:46:08 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::36fa:deca:aaeb:75da]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::36fa:deca:aaeb:75da%4]) with mapi id 15.20.8093.014; Tue, 22 Oct 2024
 13:46:07 +0000
Message-ID: <2aef96f8-21ca-70cc-9e4d-fbf13a4a6379@amd.com>
Date: Tue, 22 Oct 2024 09:46:05 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] drm/amdkfd: fix the hang caused by the write reorder to
 fence_addr
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Felix Kuehling <felix.kuehling@amd.com>, Victor Zhao <Victor.Zhao@amd.com>,
 amd-gfx@lists.freedesktop.org, =?UTF-8?Q?Christian_K=c3=b6nig?=
 <christian.koenig@amd.com>
References: <20241017083457.183631-1-Victor.Zhao@amd.com>
 <1a80e1fe-ef51-4ed4-a851-21d3c9da6c7f@amd.com>
 <1f252468-10d0-00a6-3e43-52a3672733a1@amd.com>
 <efb4b082-d518-46b6-adda-776458772e1c@gmail.com>
From: Philip Yang <yangp@amd.com>
In-Reply-To: <efb4b082-d518-46b6-adda-776458772e1c@gmail.com>
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQXPR0101CA0047.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:14::24) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5149:EE_|DM4PR12MB7502:EE_
X-MS-Office365-Filtering-Correlation-Id: 917a536c-ad8f-4217-0d24-08dcf29fe17e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|8096899003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?L2RpaWVYN0NBbmNSdk9NdGZtM0tDV3M0ZVVlcWNVdUMzdk1KdU1YV0dUSENk?=
 =?utf-8?B?T05DejlyeldtdHNGV2N0SkpBOGlXb3BjVGlGTnYxc3BGVHFlYi9yMnd0MmRB?=
 =?utf-8?B?S2dXbk1KaFQ3UFBKM2JEUmF1bndZZGgwdDQreVMva3R5YkhJL0V1TlBSejBy?=
 =?utf-8?B?eDRZQllzOGYvb20zczhvd0o3dkV3R09vcm9QQzJJblM3YVh6L1Zpc0xtQWhJ?=
 =?utf-8?B?UmtRcHRaT25zbkFLeFVKRnRWVzc3MjJxZ3FqcWlOTEh2Z1JiYlBYRzFsbTFr?=
 =?utf-8?B?Vk4vaXJQcUU1bzBxTW10K2d4aDgwTHFmMHFicGtsdWRxUkNrcTY3enk3KzV0?=
 =?utf-8?B?Zjh5Z3R6RFFIeUtZcWgybnRFWHJib1YyemJVN3hOd0U4ZDl3UGRDd29YNHcz?=
 =?utf-8?B?MnFBYVZxQm9DRzJZVVo1bGovbURzSC84UFpzODNrTENGWEZIYXBtMmlQZERm?=
 =?utf-8?B?YVBZVVZPNlRid00zSTJNcHFUbTJUek0xTXpyY0hXa1VZTFQ1Q0h3KzROYkpE?=
 =?utf-8?B?ODUyaUpHekVnajlkQU4xdzVaem1oMHlkd2xCY0VuZHJKL0lUMnJ3eTY2OTlR?=
 =?utf-8?B?aG40T2E2TGNySkY1Vk84Zkxyc1QwaGxXdFhUVHJwZStVb2xQQlZLajJsVFVQ?=
 =?utf-8?B?eGtFb2VHdGhGV01WVEhOYkdsUS9DeWk1NlRCUHVKSTZpOC9OUWdZSnV3UDd4?=
 =?utf-8?B?ZGhNNVpaenlOd2tuenNha1hieHU0NyswVnNZV1BCWG50ejRrR0Z4aTliR2xC?=
 =?utf-8?B?Y0pMNWVCKzVBWGFPQ0lhbWc0Y1hRS1VzNktKUnpyelZrWmordEdNQjk1NTQ4?=
 =?utf-8?B?UkM4NjlOOUx0VkxPZHFwRTVDQnVHckRydXR3TTNnYVF5eFlZdDBUQzVteWZs?=
 =?utf-8?B?TW9HNHIzU2RlakxyeVU3NE1OOVk4M3p1M1dXRENjMmFmVkxCMUozSmpOYmJW?=
 =?utf-8?B?UkcrNjJZSCsreUtONHFDdHlwUnF0Q2NGM2tWb09rWEcwUlpFUlV4K0RGUExD?=
 =?utf-8?B?ckUxeWdSUW5oUnI0TUtXbkdNbE40bnRjT3d5N0Izdyt4NUZxZkZWbjh6dGJ0?=
 =?utf-8?B?QWU4dk91VFU5RHM5MzVCTlp4MTRTOW8zMEh6LzZSdy9RN1pVQlRqLzJhbzFO?=
 =?utf-8?B?QmJQbHRLcGRvNFAwTmxTUGZ2UkJmR0UwUHM0akx4NlRpWHFVcXhQRWlkSVEx?=
 =?utf-8?B?Z1hNdWxLSmVWb2VXYUVWbW1uWWhyQ2RyM1Z2VGN5YXlnV1N3UlJsbWVEWnVN?=
 =?utf-8?B?dGtZZ28yZUZEUlRPY0xRUWduR21iOEFDN2pkTnh6L2RpeXprZFc1NDVsWEY2?=
 =?utf-8?B?TW9vMlBqU04xUFluMFpZQy82aG9aYW9ZYUlUci9HM1c1S0dhTDBGMi9KeGJa?=
 =?utf-8?B?dGNTZVI0cThFWGk5TktpSUdVZUtkM3VwNGNxQ2Q1dXdXcThLVG9ra1doOEdP?=
 =?utf-8?B?T0IvbHNRUFoxOG9YdkxxZ0VSZnBnVnZBcXp4cEczZXo4by9CNXlBVTBSaTlX?=
 =?utf-8?B?c1k0K1B2ckhSMzFYUjJpNm5LN25QQWQ4VDFuUTlYaEZDamhVTnBYOVBBWVlM?=
 =?utf-8?B?SThwQjRCODk0MHB4ekQ3QU1icVdZcjN0elgwYlZFTnpVSXMraXdCNWRUSEJi?=
 =?utf-8?B?OERSTmFwUnNoQmpiN3RtOFpnOUlDcHBoODhzMWord2VFTlcralRxSTQwWUEv?=
 =?utf-8?B?cDV0eDgwcU4zSmppUWFMOWNJVjZIK3hQT01Ya3hQVjhoZHA4STIwV0JRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(8096899003); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ckNzN25Ha2ZGUmJMdVF2WHZRTjg2bHNJeDljVmR4WXNhNklQUFo1V1FVSkwr?=
 =?utf-8?B?bHRjcDk3Vm1xL0pLSWdRVkdsNFJ2RXB4eHNEeDdKTFRYbnJOSDRyTmpGaklm?=
 =?utf-8?B?QWlTMStMY1UycU9KNFhLaFdMMC9uTHh2ZFoydEs4akt5T1FrL25vZlE1UU1V?=
 =?utf-8?B?cFVEdjg4SmRnOFVkaVUvMDdXaEU5ZkZYUmFoUUVxd2xJdkdnWi9EMm9Qa2lr?=
 =?utf-8?B?ZnQ2SlE1OW1IS2VYZW9mdmRIRTJlR0tqaUlXL0xoeTk3S2kvSkpqekx6b3l1?=
 =?utf-8?B?NzU3bmRoaEtDc1R4QlZUWXZHYmtlb05GeUpuUEZPVmVrNWo3QmFaVm5ob01G?=
 =?utf-8?B?K2tXVTdDVnExajBhcFhhakdLK29rWVFvK1pDdFRPY0VodzZ0RUZ2Y2xIR0Vv?=
 =?utf-8?B?ZXZnNnRXcXpmeFFqRXl0OHlmOGthd09kK3dqWjJpOVR2UGVyVy9QZlBuY09Y?=
 =?utf-8?B?NkpZMVhPZ284S2wzM09ORTJZclE4SU9WUVMra2lOb1pJOWo0VGFpSUtkcjc3?=
 =?utf-8?B?Wm55bitOQ2F2OXZFZGhtcEJUT3RGMUpEME8yTDBSK3cyenA2dlAyVUh2NVNy?=
 =?utf-8?B?YXJ6OTlKUFc5eGtvc2Z4MFI2L0lIYitKamxNVHJ4Z09BSnE5VHF2TE5SbDJZ?=
 =?utf-8?B?TW0vYys4TnoyTkExV1BiaTFDUFFaTlgyL3d2citHTGhGbWR4OENtQStDeUUx?=
 =?utf-8?B?U3hnN2JBbUljeDg2SXk2UUExeXBNT1FDRkZ2UEJQWnRVckNVSlB6dzZhcWRw?=
 =?utf-8?B?QkU0NmJyU0lOSit5ZVcweFRqZTVweEdzYTJ0MzRTZTh3Mk8vYjFubXBHM1pM?=
 =?utf-8?B?NnIyNTIwWnNaRG55R2N5N0JWOHBHSi9ER2o3aUFPS1c5MSsyQzhFb3pJT1Yy?=
 =?utf-8?B?QTYvQ1hXTmxPUHE2SGNlcTVrNVozZlpWRjhQNlNaZGptS29ENHlFZkJQVklI?=
 =?utf-8?B?VnBEVXNOakJjUmpjTHlNSzBPVDVUVkcwU2JqOFYrUWNUTDlpeG1rUFVwa2F1?=
 =?utf-8?B?cExETzlzL3ZCU2N1QWpGUGpsK0htUm5nRTZQUzJxWnJGTTdOMWFQSm13enF4?=
 =?utf-8?B?MUZxbmhHd1h6cmdFLzRwbEJZdFlFVGIwY01aaStuM0kyeXZhc0UxY2sza3pL?=
 =?utf-8?B?WmJ2bHBuY0ZxSXZDTDFGaUhiNmVJRGc1QnArTURFblJaZkx4OWw5RHkxR3VL?=
 =?utf-8?B?bEtvdUswZzRpU0hvMEtkMnFXUkcrdVd0QmxSbmduVkJwVTVUN21pdm03b1pZ?=
 =?utf-8?B?dEpRc2tTUGNsdFZLUSt4bzhjZDcvdGdjemNyY3NYc2NydzlBdjVwTDlMTE9R?=
 =?utf-8?B?Mk4vQjRnZmsySlJaWng2L3lMNVVVTkx5TzVZbm8vQWVBQTJib1N6czNZRHFD?=
 =?utf-8?B?b0tIbi9nclh3Z0t3aTV5dzVGM3VtUmNpMjZpMXNDT2JJeVZ0RUtHQ21SVENt?=
 =?utf-8?B?R1BtdVpjWVZ4Z2ZqLzNKZEQ5QU1HVmdCS3lKZGtIdDlnb3pXUjc1cnZqdnBy?=
 =?utf-8?B?T00rNTFXdWx5NnJ2WXE4U3ZWWjZMVWFUTGtxdkdiL0FzTHB6YmZJY1NsdE1M?=
 =?utf-8?B?Qm5OdTErdmRlZWYxVjlTK0pWRkdRZ1kydlJVQktiRmkzbzNGb2RnN0xCdHZC?=
 =?utf-8?B?MzQya0xqUzIxeStFQnBjaVJPcmtvMzJKYk5ZWkpCdkEyRHFySC9vY0xMbysz?=
 =?utf-8?B?R2lJMElhTkN5U2ZwQURkMkdRSzNUVXNlRjB2NjV5ZzVnQkZRK0dBaXBwTnBR?=
 =?utf-8?B?d3RyZzk0L2VCYTlTTVBzUVYxMjVKV2NVNExRb3lqMHZRL05yRGlLcUJSeUlU?=
 =?utf-8?B?SXNRaUhBdGEvZ0dZWGRlQ2lWYmV5ckZUNVEydS9YYWtyOXkxMGhEd2svdmZS?=
 =?utf-8?B?amRjZEN3TDJ4MW5kSG15WHBWMnliQzRSZGNUMlhJTHFFN0c1K0dZVFNZa2lh?=
 =?utf-8?B?Q0I5eklSTUlIZmJrVTBUdFdWS1M3UnFmZzlocmNTaFVJcFZWWG9oYnRzbHJp?=
 =?utf-8?B?NVkyZWZJTnhMcnBoandBSWdmRVUxeE1QWC96YXV2eHJkVk55dDZ1SnlSNmFZ?=
 =?utf-8?B?eTQ4cVp5Z2VvV0ZDYUM2K1dxN0hnMHRtNEh4TWRybkgrbHVCS0RGUE9BRzE0?=
 =?utf-8?Q?/K1w=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 917a536c-ad8f-4217-0d24-08dcf29fe17e
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2024 13:46:07.8864 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FN+iHv5ikXx4OTPC2xxcAIM+0aP3w45Ihp56R3nhY3Zmpu5MfCyUYz1DQ8sIKGJ3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7502
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

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 2024-10-21 04:12, Christian König
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:efb4b082-d518-46b6-adda-776458772e1c@gmail.com">Am
      18.10.24 um 23:59 schrieb Philip Yang:
      <br>
      <blockquote type="cite">On 2024-10-18 14:28, Felix Kuehling wrote:
        <br>
        <blockquote type="cite">
          <br>
          On 2024-10-17 04:34, Victor Zhao wrote:
          <br>
          <blockquote type="cite">make sure KFD_FENCE_INIT write to
            fence_addr before pm_send_query_status
            <br>
            called, to avoid qcm fence timeout caused by incorrect
            ordering.
            <br>
            <br>
            Signed-off-by: Victor Zhao <a class="moz-txt-link-rfc2396E" href="mailto:Victor.Zhao@amd.com">&lt;Victor.Zhao@amd.com&gt;</a>
            <br>
            ---
            <br>
            &nbsp; drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c | 1
            +
            <br>
            &nbsp; drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h | 2
            +-
            <br>
            &nbsp; 2 files changed, 2 insertions(+), 1 deletion(-)
            <br>
            <br>
            diff --git
            a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
            b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
            <br>
            index b2b16a812e73..d9264a353775 100644
            <br>
            --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
            <br>
            +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
            <br>
            @@ -2254,6 +2254,7 @@ static int unmap_queues_cpsch(struct
            device_queue_manager *dqm,
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto out;
            <br>
            &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *dqm-&gt;fence_addr = KFD_FENCE_INIT;
            <br>
            +&nbsp;&nbsp;&nbsp; mb();
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pm_send_query_status(&amp;dqm-&gt;packet_mgr,
            dqm-&gt;fence_gpu_addr,
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; KFD_FENCE_COMPLETED);
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* should be timed out */
            <br>
            diff --git
            a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
            b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
            <br>
            index 09ab36f8e8c6..bddb169bb301 100644
            <br>
            --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
            <br>
            +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
            <br>
            @@ -260,7 +260,7 @@ struct device_queue_manager {
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint16_t&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vmid_pasid[VMID_NUM];
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pipelines_addr;
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; fence_gpu_addr;
            <br>
            -&nbsp;&nbsp;&nbsp; uint64_t&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *fence_addr;
            <br>
            +&nbsp;&nbsp;&nbsp; volatile uint64_t&nbsp;&nbsp;&nbsp; *fence_addr;
            <br>
          </blockquote>
          <br>
          [+Christian]
          <br>
          <br>
          Is the volatile keyword really needed here? I just saw other
          patches removing volatile in some places because it's not
          sufficient, and not needed if you use memory barriers
          correctly.
          <br>
        </blockquote>
        <br>
        After reading kernel memory barrier document and below link, I
        think we need both volatile type and memory barrier, to
        guarantee F/W get the updated fence value. This fixes an CP hang
        issue on SRIOV.
        <br>
        <br>
<a class="moz-txt-link-freetext" href="https://stackoverflow.com/questions/75750110/volatile-vs-memory-barriers#:~:text=volatile%20will%20make%20sure%20that,not%20reorder%20writes%20or%20reads">https://stackoverflow.com/questions/75750110/volatile-vs-memory-barriers#:~:text=volatile%20will%20make%20sure%20that,not%20reorder%20writes%20or%20reads</a>.
        <br>
        <br>
      </blockquote>
      <br>
      No, that isn't correct. Using volatile is considered harmful and
      almost never correct, see here
      <a class="moz-txt-link-freetext" href="https://docs.kernel.org/process/volatile-considered-harmful.html">https://docs.kernel.org/process/volatile-considered-harmful.html</a>
      <br>
      <br>
      Placing appropriate memory barriers must be sufficient or
      otherwise there is a rather bad platform or compiler bug lurking
      around.
      <br>
    </blockquote>
    <p>Yes, Victor confirmed that memory barrier fixes the issue, will
      send new patch to remove the volatile type.</p>
    <p>Regards,</p>
    <p>Philip<br>
    </p>
    <blockquote type="cite" cite="mid:efb4b082-d518-46b6-adda-776458772e1c@gmail.com">
      <br>
      Regards,
      <br>
      Christian.
      <br>
      <br>
      <blockquote type="cite">Regards,
        <br>
        <br>
        Philip
        <br>
        <br>
        <blockquote type="cite">
          <br>
          Regards,
          <br>
          &nbsp; Felix
          <br>
          <br>
          <br>
          <blockquote type="cite">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct kfd_mem_obj&nbsp;&nbsp;&nbsp;
            *fence_mem;
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; active_runlist;
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sched_policy;
            <br>
          </blockquote>
        </blockquote>
      </blockquote>
      <br>
    </blockquote>
  </body>
</html>
