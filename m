Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0860CF8840
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Oct 2024 18:38:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EF6EF10EA81;
	Fri,  4 Oct 2024 18:38:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hZoVeVs4";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2053.outbound.protection.outlook.com [40.107.236.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9D36910EA81
 for <amd-gfx@lists.freedesktop.org>; Fri,  4 Oct 2024 18:38:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=feCOLpFBL/kYvcKCl2J8EVW7HGNbEUq1U93Yza/NxGxal1uv1peIwZvP4g7h79ECmG8MwSU7bERy/4o56Bk5/6EXJ6yxSNTR+OrlNzaJpBYvx4LT9zEgKGFpAStcKhgD1JpX6FyLFyTVMGKSQ68pZv8V322bsJMFMPi/PI2SJ2ADSLgVBzBVUnfU/DW+EZY0ooYS4iEAreGFZqZGc8bGOXev/qTxEqwYdhx31CfL4Pwe80mOQ+hrUUDHY3Z+sWazOh70wswoLkBKVcHMQz5ThWbVdM9M8NwG3YiYlxYbWpbMnIC5/cZHdaaNq7X8vGesYOgvaGtp2kE60hyC8jKquQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hHP2V6tLUcH8V3SsPWLcr5uJDsasJivjwlGUqQTEAFg=;
 b=uVhV1ne4FY82q66B/OPbWC1zfKLaD3Sqn3Ry1T9pujfnt1Bcs3kJS/C56LJKxtFYWMFA9RmT2g7wjgNmkWFRBM2prQ6/n6aoEsAaurtLbiOy+4pbYIhEsxOtJnkdEGC+RSXabO07d3MDz0AnugXCkehsT/cy06v7s3aUxGZNBaBdMamUF69cww24mj0B5L2V36U049eag453kdJl7hMtUgau5zTMuTJgU55uzgt6g2+iEX8oajQycsVPtE+ai/1Ok5qDChrkQm0FViKrGgWa7HROYf0Qrzz/U6oqMAkTY9IFvL3AdtXOxd9bV9YNtrJ5kyF+JOw7Msmy06MF6XRJBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hHP2V6tLUcH8V3SsPWLcr5uJDsasJivjwlGUqQTEAFg=;
 b=hZoVeVs4gktsSB76m3lqwN2JiJwbobmbg+83JPUE+pYGGwFU0WhIpA5Bk8Sndfi4qCLdXHWlsIfi0N/146Xc2IzpKN4KNkaJWLLmD5yObKq2ukS3EC2XZwICzGButrsKAQZWXVt3/wyYIdypUbbwbJIMCdIw0yDWPcQt2nIqOB4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY8PR12MB7491.namprd12.prod.outlook.com (2603:10b6:930:92::15)
 by DM4PR12MB6373.namprd12.prod.outlook.com (2603:10b6:8:a4::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8026.18; Fri, 4 Oct 2024 18:38:41 +0000
Received: from CY8PR12MB7491.namprd12.prod.outlook.com
 ([fe80::217f:1ab1:9a5f:fecc]) by CY8PR12MB7491.namprd12.prod.outlook.com
 ([fe80::217f:1ab1:9a5f:fecc%4]) with mapi id 15.20.8026.017; Fri, 4 Oct 2024
 18:38:41 +0000
Message-ID: <b6f28e35-7cc7-404f-b090-95eefcf57308@amd.com>
Date: Fri, 4 Oct 2024 14:38:39 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/18] drm/amd/pm: add new vcn enable function pointer
To: Alex Deucher <alexdeucher@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, leo.liu@amd.com, christian.koenig@amd.com, 
 alexander.deucher@amd.com, sunil.khatri@amd.com
References: <20241002043627.102414-1-boyuan.zhang@amd.com>
 <20241002043627.102414-2-boyuan.zhang@amd.com>
 <CADnq5_NSVeP8Bn9-wPK1yu--buic7=nekWJTE9HOYGKsjfyxNg@mail.gmail.com>
Content-Language: en-US
From: Boyuan Zhang <Boyuan.Zhang@amd.com>
In-Reply-To: <CADnq5_NSVeP8Bn9-wPK1yu--buic7=nekWJTE9HOYGKsjfyxNg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0260.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:68::34) To CY8PR12MB7491.namprd12.prod.outlook.com
 (2603:10b6:930:92::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR12MB7491:EE_|DM4PR12MB6373:EE_
X-MS-Office365-Filtering-Correlation-Id: cb9086b4-863c-4934-401d-08dce4a3c4db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TzdiUE5VWEZaVXpXNklnaWMrM2dEbDRIa2lEL1hSa1hoTDZqM3kxRjRXWUNo?=
 =?utf-8?B?QVFRdWdIRndBK281bzJkYk5YVVV1Rzl6Y3V1d3RUdVh4cUxQNnpJeUdCSXc0?=
 =?utf-8?B?Q1UwTFdqTSt2U1prMVk2MDQ4aWtZQ0R5TmZFb0lWZ3lRZmlrZDB5WFJJajh1?=
 =?utf-8?B?ejFzN3ZCTlRkQ0kyTkpvdytUckh5dVJadWYvL2E3cnRSK0tVNHo2YlVLaVRl?=
 =?utf-8?B?TGFoUjhPcmZJc2hEZWo1T0xZNzhYcjNLWTRnU2xkdGhUb0tXYmxMREowSTlq?=
 =?utf-8?B?SXUwelBpVmR4MS9pRzh0eEoyREUxTmFZaEJ2WUpPUDM1b2t0dGVDMU1OMXho?=
 =?utf-8?B?UE9TcVdQTFhjdDhpSmRnbXdXdXkzVFFUZWU4ZjY5NmsvTjIvcHhGSXBiVzkz?=
 =?utf-8?B?Sk9GSktxNzE5RHM2ajBzbHZyVHh4dSs5QTBDclg1ZjYwUXdXUTJaRk5wSkZk?=
 =?utf-8?B?b01qYW5IaHBRT3ZGTStzbllJTHEwV2V4clVwWk8wU3FHS0NYSHlwVFQ4OEIw?=
 =?utf-8?B?Z3NKWThBYmtselJoSGRHcFFDVWl5ZzRwbTlMS09NV2l1b1hHUlVFbW84S280?=
 =?utf-8?B?UDM2ZXBQZ2NMRitiS2NmOHByVnM1RmZ6RURNTTcwZnhtQTNSeTR2RTErcHlt?=
 =?utf-8?B?dEV2cVJyNm1yN2hkTGxQcmxQMXNVU205WlB6blgveExSc0RDK1VaUUhRQTFp?=
 =?utf-8?B?S2x1eURkRGI2M2hua2tSSDB3V0haUFZhR2pJZnhtZkxSYi8wTWJmVGFDMWpw?=
 =?utf-8?B?WGVCckZMR3hjSUNXT2RiZjdmTUUyMVJvbzNRelEzdDlNdGUza0xjTlNlZ05N?=
 =?utf-8?B?Rm1RL3lUL3RBRU9rSG9PT2JYZmk1bVFzeG81RTVhTUVkcVlqU0E5ZnVYbVV2?=
 =?utf-8?B?RXdxUHROa1ZKQjlVSUZJanc1TFdVSWdka1N5ZjBhUno1RmdQU0RLUFJGS3hV?=
 =?utf-8?B?NEM0aXFwK3kzMFBtYjVVSzhwbzJIWUtMVU9lYTNnOEVKbzFmZ2pPWDEwVklP?=
 =?utf-8?B?aFlMenR0aHloaEhwdGVXSkdRMFhjejZmVHJUZUVEczVHcnkyWml1Vldya1JY?=
 =?utf-8?B?YlRTVHpTQlBtbTNicytBSnI2VlpDVURXVTdMbkpKVDFGeE4wMlF4Vmh4Rkpo?=
 =?utf-8?B?ajhYUmR0cHEya2hDLzA1eG96YWJaMm1XSE4ySG9zdGVoYjRTek9UbzFUN2Rv?=
 =?utf-8?B?N0pHRW9wUXNENEw0YWVrOEh5UG80WDFITUpXQWp6K3RFTEZkMzlrb2xLVlM4?=
 =?utf-8?B?ZmFSUGRDRVYweEl6eWlnREh3bWhCNERLdHE3ZnlxakVzMUd0UXJVYnNkM0Zz?=
 =?utf-8?B?cTR3QzNhWHB2SGpESnMrSTVWYlV6RVh3bitYeXZ3eENlalBwSThlRzNkWnVs?=
 =?utf-8?B?V0lqaVF6b1UvQlRNN0VBMFZ5SDNyVjdxVUkwY29ZdkNPd2VQb2g5YSsxS0VX?=
 =?utf-8?B?MDZaK2xjcnNkQ1ZMbFVyZ1hJaFp1cGlUQUtyQkt1YThpVFJYSE1mQnNmcms0?=
 =?utf-8?B?ekNQckhyV0dYNHd2K1FTMzlsT2hNTU10RHhrdk9PVnpnWWRqdFdFZDNUbGVR?=
 =?utf-8?B?MTdLQnM5cVZjRlJxaUQwblRyajhzTllISkRqenYrbWpNL3BOcFZsTjkwanc4?=
 =?utf-8?B?WGpodG00Lzl2OVhNemVDWDFENUJqdHczN2dhUy9TeUFIYkpsZ21Ucmw0QThj?=
 =?utf-8?B?c1FyUUV4aWFBTk1DQVM1blpjbmFiejVtZFdvTjRzdURsc1BiY3l5cWRBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB7491.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WFlEQ1dDSmVCYnFGQ2ZISTVFVmtoYnE1ZHJxcG5TNDFpSUNteDI2bTJGZGUv?=
 =?utf-8?B?S1JQRTBLdkdiSkhteDYzQzVRTEVEWmhXa2VUWUtacTVtQ2xDU3ByQnJ0Rmlv?=
 =?utf-8?B?cjlvck1IVWVjZmRjdzE1SFc1Q1FhdlRuc09XbmRxUzJraHdWRFFkMC9EbW5H?=
 =?utf-8?B?L1lMQzNYNm5GUmZXb1pFamdndXVlYUs1bzRHVFpaVGpSQi9HOGNVYk9QS1RR?=
 =?utf-8?B?SlRUZEdRcVNsNjQ0TmNXaFdxQnRJSkJmVHpHVjd4NVFtWXU4dExRVStPalZX?=
 =?utf-8?B?Z2NaaDFzU3dMM3V5MGFBdUtQQWwvTWlsMW9EUGF0dmR1TnlQcnoxUVZSUDVx?=
 =?utf-8?B?RThubHdmMUVJMmJuWVNZeWFVc1JHRjMvbG1GMjVlaXJKK3g1eUM0REdnLzBi?=
 =?utf-8?B?U05EVmc1V0ROdTUxNS9FZEdiMHUzMjFJQ0NJaStTUlRUNkdkR24yMm1TSTFs?=
 =?utf-8?B?SG9zL0JUNnB0MmdXN3VrUklNb0VEV2RSOGJGeEc3VWtib0MrU2N6eHBUckJY?=
 =?utf-8?B?c2NJTCs3L2Z6MkIxU2lnT016SWhGeFp3S1BTd2Y5Z2QxQ0ZvNjF2Rm9rSW0r?=
 =?utf-8?B?YTE5b1IrYmJacFBrc0NzNDJCdDRncEluZUF4amFra2JudXBYb1FvbTlsdlln?=
 =?utf-8?B?aHVPWHQrRWpLZmZ1Wjl5SlFBWnBoZlBkVCtZMHNWUnMrMytXTnVHZGJuOUNJ?=
 =?utf-8?B?OU9MTFlZVGV2VU1SOG0yNlE0NmJyK0lvZDFXaUkyWjluR21YN1pUQzZkaktP?=
 =?utf-8?B?VE1Dc1h1bEExdmw4QTBpNkt6N2ltTnZTZHQ2bkpIcDE5OGtURUlYeDUxT2RT?=
 =?utf-8?B?ckRsUzVzellUSGV1VWJrTkE1YUxONkJhNEhxb1NVTzNHYUV5eDF1RVlBSWoy?=
 =?utf-8?B?WWxxVHM0OEdIR0lYeGUrcnE5dGVYQXhxVk5uT0lodjZFenYvYVFNci9JSHdj?=
 =?utf-8?B?ay9CN0YreUJQWTdwZEF0K29Id0I2ZU5OTlpvcWhiSlZlOXZwVVBBQXFha3Vv?=
 =?utf-8?B?Znd3UVRBVUpLVW81dXZJQjc2RDZZa1U3cDJQKzl1aGdNeVI1dmdzdlJDRGpw?=
 =?utf-8?B?V3FOd2t5S0hKZGpPSm02VGducytpVmk4NGFTK0phaUUzdERPNGRFbWM5cSsw?=
 =?utf-8?B?bHVLWDJjbCt3M2FRT1ZKY1RQWUNiTFg5cmtiMUllQzZzMEkrclRJYURYMnI2?=
 =?utf-8?B?amJZQ2IyTVFMU1lzSUpQUDlwNlFpSUJUQ29PQkhpUmRlM1RlU2lUcktnRC9l?=
 =?utf-8?B?cDlCcVR1S0duL0JDSHNwc1lvR2F3aUlDeGtJd2lPVzV1VGVJdmJKMCt2OHF0?=
 =?utf-8?B?Z1duNEd0ZFZoYnJPMlpIN2wyOVNrOW5SMkx2U0EwVWhiOUJEOFBKVlM1REx0?=
 =?utf-8?B?NTJnZDZTUFk3TW9Uc0hyT2ZhYXhIZlpKOUFRUlA0dG9ybVJZcTg2eDM5RmU5?=
 =?utf-8?B?Snc5RjFwclNFcXhMcGxBN3c5NVVIeHZtdTFOQmEvM0M3Z1VjM2xCUTl0S2Vl?=
 =?utf-8?B?cjU5WVdXSUY2dlZGU285Ni9lckQvSmFwemhqaFlEU1U5MDhZWDRSQ1ZvRmox?=
 =?utf-8?B?aERGZWdQMnhjSmE5RlNURldFVnRnQ2xJN3ZPMFR6UVlxU3djdnFoNkgyd1E4?=
 =?utf-8?B?NE9qRWloQVpoZ1B3bUxSRHVhSFIwS1RybUYyR3Q0Y2tNTDhGWWxkNnRlTytT?=
 =?utf-8?B?WEJoa3hTM2dtcnU0QVNRWWhoL3hqWHBNZ2xiSWo2YmNMYlVCNTAzbHUzMWdM?=
 =?utf-8?B?ZGN5bDN0bnJmTGVrZEIzc1ZuejhQM1Jsa0RSaVhIaFVmYkZQUFdFM3BoZk1j?=
 =?utf-8?B?bndhK3UySEhkYW91UVNyYlRDWmVnQnZOMVBYN3ZQZXlFVlV5S1lKOVIrVHBV?=
 =?utf-8?B?L3RJUkZ2S250dzJuM2l0U0JoK0RKZ0lubys3Vm5NUVkzTG5TWmo4eGhROG9U?=
 =?utf-8?B?T25hTm8vWmJuT0RpVkErMFVtSlVCaU5yL0dUeDdlczJCdHB4Nnc0VzlKcDMy?=
 =?utf-8?B?elV4d0xobzh3Wk82RFdMSENYaGNHQ1RXdnZjRVN1SVNWRGNvNmZCR01DWEpn?=
 =?utf-8?B?Y0FWQmk3KzNDRHlMTFdoQ1NLZmVUcUgvMk83dmUyb01tOXBvWW9IU2RjOFht?=
 =?utf-8?Q?ZfhYiMnANTYLmM4baKzxUCQkN?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb9086b4-863c-4934-401d-08dce4a3c4db
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7491.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2024 18:38:41.4995 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JGynbWICnpSgD5w7CsbQEyLOs1dReklwoJBgrh+OoPR9B00e8nhyAnGvODwn8Ua4HT5tgPK2ub8WLt79qSVvIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6373
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


On 2024-10-02 13:10, Alex Deucher wrote:
> On Wed, Oct 2, 2024 at 12:38 AM <boyuan.zhang@amd.com> wrote:
>> From: Boyuan Zhang <boyuan.zhang@amd.com>
>>
>> The new function dpm_set_vcn_enable_instance() will be used to enable
>> or disable vcn engine dynamic power for the given vcn instance.
>>
>> The original function dpm_set_vcn_enable() will still be used to enable
>> or disable vcn engine dynamic power for all vcn instances as before.
>>
>> Signed-off-by: Boyuan Zhang <boyuan.zhang@amd.com>
>> ---
>>   drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h | 8 +++++++-
>>   1 file changed, 7 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
>> index 727da0c37e06..f88241cdf9b9 100644
>> --- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
>> +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
>> @@ -737,10 +737,16 @@ struct pptable_funcs {
>>
>>          /**
>>           * @dpm_set_vcn_enable: Enable/disable VCN engine dynamic power
>> -        *                      management.
>> +        *                      management for all instance.
>>           */
>>          int (*dpm_set_vcn_enable)(struct smu_context *smu, bool enable);
> Wouldn't it be cleaner to just add an instance parameter to the
> existing function?
>
> Alex


Right, it's much cleaner to use existing function.

Removed all duplicated functions and added instance parameter to 
existing functions instead. Please check the new v2 patch set.

Regards,
Boyuan


>
>
>> +       /**
>> +       * @dpm_set_vcn_enable_instance: Enable/disable VCN engine dynamic power
>> +       *                      management for given instance.
>> +       */
>> +       int (*dpm_set_vcn_enable_instance)(struct smu_context *smu, bool enable, int inst);
>> +
>>          /**
>>           * @dpm_set_jpeg_enable: Enable/disable JPEG engine dynamic power
>>           *                       management.
>> --
>> 2.34.1
>>
