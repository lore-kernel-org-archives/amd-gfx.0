Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 622C4C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Dec 2021 06:22:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D0EE110E1F6;
	Tue, 21 Dec 2021 06:22:09 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2066.outbound.protection.outlook.com [40.107.93.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3EC0F10E1F6
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Dec 2021 06:22:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VJuyCZBV5+zAYCLrWZz5Q+Uf/bgV0rrFZNVb3OhQhXMsQamoJqouZf/u7S6TpFsYDBoSLcU5S0YaaFFUAP0reXd6SwGVsP1Dew9NGnwUcwxAXu+9WG7S29ksUWJ999M62bThIpYjowQxTBaDC0j8LqxK6sNa3x33haTvK8nC3xo+2LEIvzOWN5KuKRVeTeXbICRJFbrdx5dkmf46i6JyytHVbbwnUoNwTCZGSu/63Vr/KXmlObTjrz6jlZBpCOB4D6w9yTZ+dGghoCojZPN6xwQseWKrjRgIPLd9S14X5zR846kf7b9575CzhyTPdjeyfcj8yEGqV7g+B3HkHNkEEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6oogcfD1kvTD5n0Um5sAk8baFnK77iD67HHWjfHpi88=;
 b=J5X9q+hVsg29Oo6Xrvd9FDmTIc83caMYLZTWx7z5emOoQLqT0GkfZH9psItl2xzcI8FPcMu6A0FkuHjB30UBwUVFA1tYP7r3WXAJuZuv0SJ6cmqL/fUPYyByx7JtgGhkxqT5YuEtDHm9sXcHKyh9DdFC67YWGXgvIyKnqQpwt8KZrHRc9ZGMag4+nM1TIZL0gFrvXV6rmTlGnQhIORKOFKwMRDIIKTLQ04uVLfvxD47SjIbl+SP8TTUcUndJy+4SLAHycqzf/cr0AO3LZvWVQMzC+aLQ5Ml/rpvpHSdxrzxC8Lq4d18AFr524P5y9LCflXIs210C/4pHfTrozWGL6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6oogcfD1kvTD5n0Um5sAk8baFnK77iD67HHWjfHpi88=;
 b=XALwMa1vpRuNSSDDq2GcMPI3fOTBybaoskehze5BN5Kt3NgoQVdXYmvDSx+qbdkpPd3OwlHf9HzUpbn3Bg4eViGyg/A1/9u4Gs2AAMQVZeHCUeWfR0I8jAvpnNnqhjuQcSzD0rhiA+kc1sUL8cC2a7chfYBNWkeqqVTJ4L6UtXM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3930.namprd12.prod.outlook.com (2603:10b6:5:1c9::19)
 by DM5PR12MB2582.namprd12.prod.outlook.com (2603:10b6:4:b5::37) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.17; Tue, 21 Dec
 2021 06:22:05 +0000
Received: from DM6PR12MB3930.namprd12.prod.outlook.com
 ([fe80::41ea:d7dc:f041:633c]) by DM6PR12MB3930.namprd12.prod.outlook.com
 ([fe80::41ea:d7dc:f041:633c%5]) with mapi id 15.20.4801.020; Tue, 21 Dec 2021
 06:22:05 +0000
Message-ID: <9520c003-0321-0d5b-ce06-e2449d52e079@amd.com>
Date: Tue, 21 Dec 2021 11:51:52 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH V5 13/16] drm/amd/pm: relocate the power related headers
Content-Language: en-US
To: Evan Quan <evan.quan@amd.com>, amd-gfx@lists.freedesktop.org
References: <20211213035223.772700-1-evan.quan@amd.com>
 <20211213035223.772700-14-evan.quan@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20211213035223.772700-14-evan.quan@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0027.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:97::11) To DM6PR12MB3930.namprd12.prod.outlook.com
 (2603:10b6:5:1c9::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 67e4a316-2e04-4068-ec99-08d9c44a3551
X-MS-TrafficTypeDiagnostic: DM5PR12MB2582:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB2582C0E5691C42ABADB4C7A9977C9@DM5PR12MB2582.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CaLOpzqlDG6u6TtGKPhogRF1Imlja+4HVChbvCoQrN3mzKlsW/6kemGBulHTskZsHb9MrXtE7KtlgjigMMb12KOOg5x6IAicJtC6bm+aTo/4EPt+YAqFZrMteCOFHJU3fSJVr4I37nCbGSmIdXqKN4rnFbDnI2hUwy7BLERzU6lyOaCwEb0EweezRTnnA/35GX9IuAqU+9C9MF06oY0yBpatXclM2LcLayN/dbflbF4dFUtLLbs1A1jRXErI5CfAweEiguXoQZB5LdrK9E/kWvB5XiAAQyFC+q1GTuq3jhoH+wg58iMBJbm8wzh16DJGBfyXLPPD6UaCbJvS8WhcM+rC5Mx/yN9f71Yy8zzHEE+9WlyFjHmLV52OTfUj6HBbODzx/cFxepUvugoqCrwPXoYTZ7E6A26Gdnr7DEdhC/UlMyQtQJPI1a5Kve5XqQoQ9y1C9PCsryBMecaq1lJpjplm5XGXeR0Jhnrc0yCCt0+A75dyJqu7zjL8BnpuoBx28WOHiRpoxexQO4ldJImIS+MlA5t3Q5Yg/7F28naO+CKSrexXqjg7K5n5FL3AWKjm2buCFmyxskuMc5aT1MsgqZJD4aCpY2ofi+5AC5jpOj1FUmVogaVOLMvdlhMKny/j6gIb4H7OKzwq1b19wsztGa3fx9+F0Og3zK6+28fGoTO1AiZWHeMs1/Kcrm4Q71vuvhMBDHAYRm/08t8G4om09kIo3Iq3OoQrmYjorqxwfDUq0FPG3ZRCNAzkHY2lg/SO
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3930.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(6486002)(316002)(31696002)(53546011)(86362001)(38100700002)(83380400001)(8936002)(186003)(2616005)(508600001)(4326008)(5660300002)(31686004)(26005)(30864003)(6512007)(6506007)(66946007)(2906002)(66476007)(36756003)(8676002)(6666004)(66556008)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZTVvQzVRR295aWpIQmp2NVhNUmREcm1hTnpMOHN1cUVFM0xVNk5pTllZMmRB?=
 =?utf-8?B?YzRhUUVJZTNqVVFHdWVKRzl0aVhCMnB2SEYvZ1VrQUlqZEw3SDlGa09GS3dH?=
 =?utf-8?B?ckVTTjQyUUI1YUM0RjdMU1BUdXVWWXV3WUpyMUF4bGJESEVZMDYxSkhtZmVH?=
 =?utf-8?B?S3YyWi9aTWd0Rno3YndKMEUvY2JVVzNWdG1ZelJWUFB6aWdqS1ZnbVYzbU94?=
 =?utf-8?B?cmpWWW5Hbk1nL2ZSdEk2QkpMNFZ4QUx2Z3R3aTJucGZRaXU5ZjBzSW42UGk4?=
 =?utf-8?B?VFJNZnNJTkZ1WE4yR3dDMHFTZmRkSEswNzdnMEFjQlorOHJQMmsyaVc1b3U2?=
 =?utf-8?B?ang3Q1FlQmVVVlpjTS90UGtpcmVyOFpTVHpQNi9XUUV3dEN0a0hOWkY4K2lL?=
 =?utf-8?B?MGZYYUtuei8rT0F4d01hUlNlNlNDTE1XZCtSRnVUUktuR2dRaGdEME1RekVF?=
 =?utf-8?B?cW9EdEY3Y1F5cDBldXp4Zkx3QmtXeC9qMlhYYm1RK1ZFeUZuWHlKbFpXUnd0?=
 =?utf-8?B?T3JKK2MzM2dIYkFYR3Jhenc5YTU0TlJuNk1wOEtEWjVadHh1NnBhUzk5U29t?=
 =?utf-8?B?UzFZUTFDcFJGZDM3Qm1ZZnI1UzlmaC9zZUZzTDJlMThpRGlNSWZLNEI5cWJT?=
 =?utf-8?B?SVM2dTc1L25MRGlpVDZKMGNUK1VNajZBTmV5V1ZMbi92ZnpqVXVMTjM5WVRR?=
 =?utf-8?B?NkpuaGp4TnNwcEdIL3F0anFuUkxFMjZORnRreVcvcnVjdzVWMjNBU08vb0lS?=
 =?utf-8?B?ZzFrSFNWcE1uZzZnS2gzaDNFazY1V3FWUk5BQUxFb01UVXhSNUNYTFdYQVph?=
 =?utf-8?B?cjZ4UmpXU1B1VVVhRE9hL0JKTUltMG5GRXNNM2tRUE1ZeGRyMTRqdVRYNEpm?=
 =?utf-8?B?Z2Zrd3JSNjhLOEVqVUxueTJZZ0ZhNFR4S2FXTDlGRlI2ckRzSCt1SFl1Vkxo?=
 =?utf-8?B?dVdja3R5NGo1KzhDYnQyV1ZEYUtjZm1GYXZITVNwYVZJeUpJeGpjS0YwMU05?=
 =?utf-8?B?YkFVNGpNNDFuaFh5SWtXaWdvUVV2Ym9BL0R0K0dheVlGeHVPMTN4bldqcWsv?=
 =?utf-8?B?NWFpWG9jdDUweUo4bEM3NktkbXQyZUVBNnMwdHg5YkdPVGVkcDlaazhPMmpQ?=
 =?utf-8?B?N2wwc3Z1Y0FhOURkQ2tIbklBdFZjZURDdTdPMDRQb3NTNUZmWllabVlXNUdv?=
 =?utf-8?B?MS9FVDJ3UlZRdWJGSzBRQUZaR0MyRTROS0NoODJjTFRERFdTT2JaTUFQeTNE?=
 =?utf-8?B?SmM5blZhSHIzVDg2NmZGUVNxbnFpbTlFT1hzTXVsL0ZQLzRwUGxBbnp5Nmp5?=
 =?utf-8?B?RmZsT05WY0ducUFEZGxROWVLSXZFWVJiYlB6WERkOGtpY1JIT3kyZ2puQ1pP?=
 =?utf-8?B?cWVZVDhYM2tEZ0gxWDlsSzJvRGNoWUREblNqdkZUZzZkNHI4MkwxZHRBQXRk?=
 =?utf-8?B?UFpCL242b3Z0NG8wckNBaGNMcTBVZG51VmhUdHI1bzQvQUlUVUFUOEJCZjkw?=
 =?utf-8?B?UTdCRXJocUhMeGZha0svRjV6RzFtNkdRUXpSN0szRjJBajNCbU15dFBzTUUz?=
 =?utf-8?B?T1kwazlsNWVyRE1GaE4xa2dTa3czbm5ZNDk3eWRqQ1hXN3IzUVpESGRqSEpt?=
 =?utf-8?B?b0pxQjc4M3J1dlpkNlBoaFFwWXhBR3E1RHZ5NXhPV2U2aVZueVJWUVh6aTdj?=
 =?utf-8?B?bzBvRGhINi9jR3lwSVZtNDQ0Ri82Tk1IVWdUdkU5TG11Y2FDY1o4KzVJa1VV?=
 =?utf-8?B?MlAyT2tkNmNJd1FqZlJnU2NEZ1FQakQxN1NMR0l2TWVIYVpRQUpOV0pKOGUx?=
 =?utf-8?B?aXFnajYzaGhUNjFoK01JWVlSTFNzTk5ERmk5Y3dtWXJQRllkRUFSTVlYc0hm?=
 =?utf-8?B?NkhjbzdyY0ViNXRVNWNJY3pKbzNLdURSNUdJN2s5ZzFjcDZZeUt4SnRTRVBj?=
 =?utf-8?B?a3BNcHBkRFpVQjgwM0lHK090RUZjUGgvYjhkQlhnc2hSaURpUm9QRkRrQldn?=
 =?utf-8?B?UTIvUzRqcmVkR25hR1RDYjdlVTNNMXNXWnEyQ1ZWNHRtQWd2NnVnV21md212?=
 =?utf-8?B?T0FmUGVYK0Q1MXpnNlIzN0ZJU1YvRHhqRmNzTWZpdFZUb2pETFFmUWduYXp4?=
 =?utf-8?Q?Uq/A=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67e4a316-2e04-4068-ec99-08d9c44a3551
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3930.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Dec 2021 06:22:05.4339 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SvhEk4zAcupZUBFHZ2zlVavSKFKTnanrcLu7PhmHAC2p97/wtzKrxcfxsqh2QS9N
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2582
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
Cc: Alexander.Deucher@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 12/13/2021 9:22 AM, Evan Quan wrote:
> Instead of centralizing all headers in the same folder. Separate them into
> different folders and place them among those source files those who really
> need them.
> 
> Signed-off-by: Evan Quan <evan.quan@amd.com>
> Change-Id: Id74cb4c7006327ca7ecd22daf17321e417c4aa71
> --
> v1->v2:
>    - create separate holders for driver_if and ppsmc headers(Lijo)
> ---
>   drivers/gpu/drm/amd/pm/Makefile               | 12 ++++---
>   drivers/gpu/drm/amd/pm/legacy-dpm/Makefile    | 32 +++++++++++++++++++
>   .../pm/{powerplay => legacy-dpm}/cik_dpm.h    |  0
>   .../amd/pm/{powerplay => legacy-dpm}/kv_dpm.c |  0
>   .../amd/pm/{powerplay => legacy-dpm}/kv_dpm.h |  0
>   .../amd/pm/{powerplay => legacy-dpm}/kv_smc.c |  0
>   .../pm/{powerplay => legacy-dpm}/legacy_dpm.c |  0
>   .../pm/{powerplay => legacy-dpm}/legacy_dpm.h |  0
>   .../amd/pm/{powerplay => legacy-dpm}/ppsmc.h  |  0
>   .../pm/{powerplay => legacy-dpm}/r600_dpm.h   |  0
>   .../amd/pm/{powerplay => legacy-dpm}/si_dpm.c |  0
>   .../amd/pm/{powerplay => legacy-dpm}/si_dpm.h |  0
>   .../amd/pm/{powerplay => legacy-dpm}/si_smc.c |  0
>   .../{powerplay => legacy-dpm}/sislands_smc.h  |  0
>   drivers/gpu/drm/amd/pm/powerplay/Makefile     |  6 +---
>   .../pm/{ => powerplay}/inc/amd_powerplay.h    |  0
>   .../drm/amd/pm/{ => powerplay}/inc/cz_ppsmc.h |  0
>   .../amd/pm/{ => powerplay}/inc/fiji_ppsmc.h   |  0
>   .../pm/{ => powerplay}/inc/hardwaremanager.h  |  0
>   .../drm/amd/pm/{ => powerplay}/inc/hwmgr.h    |  0
>   .../{ => powerplay}/inc/polaris10_pwrvirus.h  |  0
>   .../amd/pm/{ => powerplay}/inc/power_state.h  |  0
>   .../drm/amd/pm/{ => powerplay}/inc/pp_debug.h |  0
>   .../amd/pm/{ => powerplay}/inc/pp_endian.h    |  0
>   .../amd/pm/{ => powerplay}/inc/pp_thermal.h   |  0
>   .../amd/pm/{ => powerplay}/inc/ppinterrupt.h  |  0
>   .../drm/amd/pm/{ => powerplay}/inc/rv_ppsmc.h |  0
>   .../drm/amd/pm/{ => powerplay}/inc/smu10.h    |  0
>   .../pm/{ => powerplay}/inc/smu10_driver_if.h  |  0
>   .../pm/{ => powerplay}/inc/smu11_driver_if.h  |  0
>   .../gpu/drm/amd/pm/{ => powerplay}/inc/smu7.h |  0
>   .../drm/amd/pm/{ => powerplay}/inc/smu71.h    |  0
>   .../pm/{ => powerplay}/inc/smu71_discrete.h   |  0
>   .../drm/amd/pm/{ => powerplay}/inc/smu72.h    |  0
>   .../pm/{ => powerplay}/inc/smu72_discrete.h   |  0
>   .../drm/amd/pm/{ => powerplay}/inc/smu73.h    |  0
>   .../pm/{ => powerplay}/inc/smu73_discrete.h   |  0
>   .../drm/amd/pm/{ => powerplay}/inc/smu74.h    |  0
>   .../pm/{ => powerplay}/inc/smu74_discrete.h   |  0
>   .../drm/amd/pm/{ => powerplay}/inc/smu75.h    |  0
>   .../pm/{ => powerplay}/inc/smu75_discrete.h   |  0
>   .../amd/pm/{ => powerplay}/inc/smu7_common.h  |  0
>   .../pm/{ => powerplay}/inc/smu7_discrete.h    |  0
>   .../amd/pm/{ => powerplay}/inc/smu7_fusion.h  |  0
>   .../amd/pm/{ => powerplay}/inc/smu7_ppsmc.h   |  0
>   .../gpu/drm/amd/pm/{ => powerplay}/inc/smu8.h |  0
>   .../amd/pm/{ => powerplay}/inc/smu8_fusion.h  |  0
>   .../gpu/drm/amd/pm/{ => powerplay}/inc/smu9.h |  0
>   .../pm/{ => powerplay}/inc/smu9_driver_if.h   |  0
>   .../{ => powerplay}/inc/smu_ucode_xfer_cz.h   |  0
>   .../{ => powerplay}/inc/smu_ucode_xfer_vi.h   |  0
>   .../drm/amd/pm/{ => powerplay}/inc/smumgr.h   |  0
>   .../amd/pm/{ => powerplay}/inc/tonga_ppsmc.h  |  0
>   .../amd/pm/{ => powerplay}/inc/vega10_ppsmc.h |  0
>   .../inc/vega12/smu9_driver_if.h               |  0
>   .../amd/pm/{ => powerplay}/inc/vega12_ppsmc.h |  0
>   .../amd/pm/{ => powerplay}/inc/vega20_ppsmc.h |  0
>   .../drm/amd/pm/{ => swsmu}/inc/amdgpu_smu.h   |  0
>   .../inc/interface}/smu11_driver_if_arcturus.h |  0
>   .../smu11_driver_if_cyan_skillfish.h          |  0
>   .../inc/interface}/smu11_driver_if_navi10.h   |  0
>   .../smu11_driver_if_sienna_cichlid.h          |  0
>   .../inc/interface}/smu11_driver_if_vangogh.h  |  0
>   .../inc/interface}/smu12_driver_if.h          |  0
>   .../interface}/smu13_driver_if_aldebaran.h    |  0
>   .../interface}/smu13_driver_if_yellow_carp.h  |  0
>   .../inc/interface}/smu_v11_5_pmfw.h           |  0
>   .../inc/interface}/smu_v11_8_pmfw.h           |  0
>   .../inc/interface}/smu_v13_0_1_pmfw.h         |  0
>   .../inc/message}/aldebaran_ppsmc.h            |  0
>   .../inc/message}/arcturus_ppsmc.h             |  0
>   .../inc/message}/smu_v11_0_7_ppsmc.h          |  0
>   .../inc/message}/smu_v11_0_ppsmc.h            |  0
>   .../inc/message}/smu_v11_5_ppsmc.h            |  0
>   .../inc/message}/smu_v11_8_ppsmc.h            |  0
>   .../inc/message}/smu_v12_0_ppsmc.h            |  0
>   .../inc/message}/smu_v13_0_1_ppsmc.h          |  0
>   .../pm/{ => swsmu}/inc/smu_11_0_cdr_table.h   |  0
>   .../drm/amd/pm/{ => swsmu}/inc/smu_types.h    |  0
>   .../drm/amd/pm/{ => swsmu}/inc/smu_v11_0.h    |  0
>   .../pm/{ => swsmu}/inc/smu_v11_0_7_pptable.h  |  0
>   .../pm/{ => swsmu}/inc/smu_v11_0_pptable.h    |  0
>   .../drm/amd/pm/{ => swsmu}/inc/smu_v12_0.h    |  0
>   .../drm/amd/pm/{ => swsmu}/inc/smu_v13_0.h    |  0
>   .../pm/{ => swsmu}/inc/smu_v13_0_pptable.h    |  0
>   .../gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c |  1 -
>   .../drm/amd/pm/swsmu/smu13/aldebaran_ppt.c    |  1 -
>   87 files changed, 41 insertions(+), 11 deletions(-)
>   create mode 100644 drivers/gpu/drm/amd/pm/legacy-dpm/Makefile
>   rename drivers/gpu/drm/amd/pm/{powerplay => legacy-dpm}/cik_dpm.h (100%)
>   rename drivers/gpu/drm/amd/pm/{powerplay => legacy-dpm}/kv_dpm.c (100%)
>   rename drivers/gpu/drm/amd/pm/{powerplay => legacy-dpm}/kv_dpm.h (100%)
>   rename drivers/gpu/drm/amd/pm/{powerplay => legacy-dpm}/kv_smc.c (100%)
>   rename drivers/gpu/drm/amd/pm/{powerplay => legacy-dpm}/legacy_dpm.c (100%)
>   rename drivers/gpu/drm/amd/pm/{powerplay => legacy-dpm}/legacy_dpm.h (100%)
>   rename drivers/gpu/drm/amd/pm/{powerplay => legacy-dpm}/ppsmc.h (100%)
>   rename drivers/gpu/drm/amd/pm/{powerplay => legacy-dpm}/r600_dpm.h (100%)
>   rename drivers/gpu/drm/amd/pm/{powerplay => legacy-dpm}/si_dpm.c (100%)
>   rename drivers/gpu/drm/amd/pm/{powerplay => legacy-dpm}/si_dpm.h (100%)
>   rename drivers/gpu/drm/amd/pm/{powerplay => legacy-dpm}/si_smc.c (100%)
>   rename drivers/gpu/drm/amd/pm/{powerplay => legacy-dpm}/sislands_smc.h (100%)
>   rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/amd_powerplay.h (100%)
>   rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/cz_ppsmc.h (100%)
>   rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/fiji_ppsmc.h (100%)
>   rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/hardwaremanager.h (100%)
>   rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/hwmgr.h (100%)
>   rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/polaris10_pwrvirus.h (100%)
>   rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/power_state.h (100%)
>   rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/pp_debug.h (100%)
>   rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/pp_endian.h (100%)
>   rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/pp_thermal.h (100%)
>   rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/ppinterrupt.h (100%)
>   rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/rv_ppsmc.h (100%)
>   rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/smu10.h (100%)
>   rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/smu10_driver_if.h (100%)
>   rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/smu11_driver_if.h (100%)
>   rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/smu7.h (100%)
>   rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/smu71.h (100%)
>   rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/smu71_discrete.h (100%)
>   rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/smu72.h (100%)
>   rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/smu72_discrete.h (100%)
>   rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/smu73.h (100%)
>   rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/smu73_discrete.h (100%)
>   rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/smu74.h (100%)
>   rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/smu74_discrete.h (100%)
>   rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/smu75.h (100%)
>   rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/smu75_discrete.h (100%)
>   rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/smu7_common.h (100%)
>   rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/smu7_discrete.h (100%)
>   rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/smu7_fusion.h (100%)
>   rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/smu7_ppsmc.h (100%)
>   rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/smu8.h (100%)
>   rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/smu8_fusion.h (100%)
>   rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/smu9.h (100%)
>   rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/smu9_driver_if.h (100%)
>   rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/smu_ucode_xfer_cz.h (100%)
>   rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/smu_ucode_xfer_vi.h (100%)
>   rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/smumgr.h (100%)
>   rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/tonga_ppsmc.h (100%)
>   rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/vega10_ppsmc.h (100%)
>   rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/vega12/smu9_driver_if.h (100%)
>   rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/vega12_ppsmc.h (100%)
>   rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/vega20_ppsmc.h (100%)
>   rename drivers/gpu/drm/amd/pm/{ => swsmu}/inc/amdgpu_smu.h (100%)
>   rename drivers/gpu/drm/amd/pm/{inc => swsmu/inc/interface}/smu11_driver_if_arcturus.h (100%)
>   rename drivers/gpu/drm/amd/pm/{inc => swsmu/inc/interface}/smu11_driver_if_cyan_skillfish.h (100%)
>   rename drivers/gpu/drm/amd/pm/{inc => swsmu/inc/interface}/smu11_driver_if_navi10.h (100%)
>   rename drivers/gpu/drm/amd/pm/{inc => swsmu/inc/interface}/smu11_driver_if_sienna_cichlid.h (100%)
>   rename drivers/gpu/drm/amd/pm/{inc => swsmu/inc/interface}/smu11_driver_if_vangogh.h (100%)
>   rename drivers/gpu/drm/amd/pm/{inc => swsmu/inc/interface}/smu12_driver_if.h (100%)
>   rename drivers/gpu/drm/amd/pm/{inc => swsmu/inc/interface}/smu13_driver_if_aldebaran.h (100%)
>   rename drivers/gpu/drm/amd/pm/{inc => swsmu/inc/interface}/smu13_driver_if_yellow_carp.h (100%)
>   rename drivers/gpu/drm/amd/pm/{inc => swsmu/inc/interface}/smu_v11_5_pmfw.h (100%)
>   rename drivers/gpu/drm/amd/pm/{inc => swsmu/inc/interface}/smu_v11_8_pmfw.h (100%)
>   rename drivers/gpu/drm/amd/pm/{inc => swsmu/inc/interface}/smu_v13_0_1_pmfw.h (100%)
>   rename drivers/gpu/drm/amd/pm/{inc => swsmu/inc/message}/aldebaran_ppsmc.h (100%)
>   rename drivers/gpu/drm/amd/pm/{inc => swsmu/inc/message}/arcturus_ppsmc.h (100%)
>   rename drivers/gpu/drm/amd/pm/{inc => swsmu/inc/message}/smu_v11_0_7_ppsmc.h (100%)
>   rename drivers/gpu/drm/amd/pm/{inc => swsmu/inc/message}/smu_v11_0_ppsmc.h (100%)
>   rename drivers/gpu/drm/amd/pm/{inc => swsmu/inc/message}/smu_v11_5_ppsmc.h (100%)
>   rename drivers/gpu/drm/amd/pm/{inc => swsmu/inc/message}/smu_v11_8_ppsmc.h (100%)
>   rename drivers/gpu/drm/amd/pm/{inc => swsmu/inc/message}/smu_v12_0_ppsmc.h (100%)
>   rename drivers/gpu/drm/amd/pm/{inc => swsmu/inc/message}/smu_v13_0_1_ppsmc.h (100%)

I didn't mean to separate them to two different folders. Original 
intention was to group together FW headers as 'third party component' 
headers in a separate folder.

As another thought, 'interface' folder also looks good but for a 
different purpose - to keep the public API headers of swsmu and 
powerplay components to other components.

Thanks,
Lijo

>   rename drivers/gpu/drm/amd/pm/{ => swsmu}/inc/smu_11_0_cdr_table.h (100%)
>   rename drivers/gpu/drm/amd/pm/{ => swsmu}/inc/smu_types.h (100%)
>   rename drivers/gpu/drm/amd/pm/{ => swsmu}/inc/smu_v11_0.h (100%)
>   rename drivers/gpu/drm/amd/pm/{ => swsmu}/inc/smu_v11_0_7_pptable.h (100%)
>   rename drivers/gpu/drm/amd/pm/{ => swsmu}/inc/smu_v11_0_pptable.h (100%)
>   rename drivers/gpu/drm/amd/pm/{ => swsmu}/inc/smu_v12_0.h (100%)
>   rename drivers/gpu/drm/amd/pm/{ => swsmu}/inc/smu_v13_0.h (100%)
>   rename drivers/gpu/drm/amd/pm/{ => swsmu}/inc/smu_v13_0_pptable.h (100%)
> 
> diff --git a/drivers/gpu/drm/amd/pm/Makefile b/drivers/gpu/drm/amd/pm/Makefile
> index d35ffde387f1..3d17ffb77f31 100644
> --- a/drivers/gpu/drm/amd/pm/Makefile
> +++ b/drivers/gpu/drm/amd/pm/Makefile
> @@ -21,20 +21,24 @@
>   #
>   
>   subdir-ccflags-y += \
> -		-I$(FULL_AMD_PATH)/pm/inc/  \
>   		-I$(FULL_AMD_PATH)/include/asic_reg  \
>   		-I$(FULL_AMD_PATH)/include  \
> +		-I$(FULL_AMD_PATH)/pm/inc/  \
>   		-I$(FULL_AMD_PATH)/pm/swsmu \
> +		-I$(FULL_AMD_PATH)/pm/swsmu/inc \
> +		-I$(FULL_AMD_PATH)/pm/swsmu/inc/interface \
> +		-I$(FULL_AMD_PATH)/pm/swsmu/inc/message \
>   		-I$(FULL_AMD_PATH)/pm/swsmu/smu11 \
>   		-I$(FULL_AMD_PATH)/pm/swsmu/smu12 \
>   		-I$(FULL_AMD_PATH)/pm/swsmu/smu13 \
> -		-I$(FULL_AMD_PATH)/pm/powerplay \
> +		-I$(FULL_AMD_PATH)/pm/powerplay/inc \
>   		-I$(FULL_AMD_PATH)/pm/powerplay/smumgr\
> -		-I$(FULL_AMD_PATH)/pm/powerplay/hwmgr
> +		-I$(FULL_AMD_PATH)/pm/powerplay/hwmgr \
> +		-I$(FULL_AMD_PATH)/pm/legacy-dpm
>   
>   AMD_PM_PATH = ../pm
>   
> -PM_LIBS = swsmu powerplay
> +PM_LIBS = swsmu powerplay legacy-dpm
>   
>   AMD_PM = $(addsuffix /Makefile,$(addprefix $(FULL_AMD_PATH)/pm/,$(PM_LIBS)))
>   
> diff --git a/drivers/gpu/drm/amd/pm/legacy-dpm/Makefile b/drivers/gpu/drm/amd/pm/legacy-dpm/Makefile
> new file mode 100644
> index 000000000000..baa4265d1daa
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/pm/legacy-dpm/Makefile
> @@ -0,0 +1,32 @@
> +#
> +# Copyright 2021 Advanced Micro Devices, Inc.
> +#
> +# Permission is hereby granted, free of charge, to any person obtaining a
> +# copy of this software and associated documentation files (the "Software"),
> +# to deal in the Software without restriction, including without limitation
> +# the rights to use, copy, modify, merge, publish, distribute, sublicense,
> +# and/or sell copies of the Software, and to permit persons to whom the
> +# Software is furnished to do so, subject to the following conditions:
> +#
> +# The above copyright notice and this permission notice shall be included in
> +# all copies or substantial portions of the Software.
> +#
> +# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> +# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> +# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
> +# THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
> +# OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
> +# ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> +# OTHER DEALINGS IN THE SOFTWARE.
> +#
> +
> +AMD_LEGACYDPM_PATH = ../pm/legacy-dpm
> +
> +LEGACYDPM_MGR-y = legacy_dpm.o
> +
> +LEGACYDPM_MGR-$(CONFIG_DRM_AMDGPU_CIK)+= kv_dpm.o kv_smc.o
> +LEGACYDPM_MGR-$(CONFIG_DRM_AMDGPU_SI)+= si_dpm.o si_smc.o
> +
> +AMD_LEGACYDPM_POWER = $(addprefix $(AMD_LEGACYDPM_PATH)/,$(LEGACYDPM_MGR-y))
> +
> +AMD_POWERPLAY_FILES += $(AMD_LEGACYDPM_POWER)
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/cik_dpm.h b/drivers/gpu/drm/amd/pm/legacy-dpm/cik_dpm.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/pm/powerplay/cik_dpm.h
> rename to drivers/gpu/drm/amd/pm/legacy-dpm/cik_dpm.h
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/kv_dpm.c b/drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c
> similarity index 100%
> rename from drivers/gpu/drm/amd/pm/powerplay/kv_dpm.c
> rename to drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/kv_dpm.h b/drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/pm/powerplay/kv_dpm.h
> rename to drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.h
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/kv_smc.c b/drivers/gpu/drm/amd/pm/legacy-dpm/kv_smc.c
> similarity index 100%
> rename from drivers/gpu/drm/amd/pm/powerplay/kv_smc.c
> rename to drivers/gpu/drm/amd/pm/legacy-dpm/kv_smc.c
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/legacy_dpm.c b/drivers/gpu/drm/amd/pm/legacy-dpm/legacy_dpm.c
> similarity index 100%
> rename from drivers/gpu/drm/amd/pm/powerplay/legacy_dpm.c
> rename to drivers/gpu/drm/amd/pm/legacy-dpm/legacy_dpm.c
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/legacy_dpm.h b/drivers/gpu/drm/amd/pm/legacy-dpm/legacy_dpm.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/pm/powerplay/legacy_dpm.h
> rename to drivers/gpu/drm/amd/pm/legacy-dpm/legacy_dpm.h
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/ppsmc.h b/drivers/gpu/drm/amd/pm/legacy-dpm/ppsmc.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/pm/powerplay/ppsmc.h
> rename to drivers/gpu/drm/amd/pm/legacy-dpm/ppsmc.h
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/r600_dpm.h b/drivers/gpu/drm/amd/pm/legacy-dpm/r600_dpm.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/pm/powerplay/r600_dpm.h
> rename to drivers/gpu/drm/amd/pm/legacy-dpm/r600_dpm.h
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/si_dpm.c b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
> similarity index 100%
> rename from drivers/gpu/drm/amd/pm/powerplay/si_dpm.c
> rename to drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/si_dpm.h b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/pm/powerplay/si_dpm.h
> rename to drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.h
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/si_smc.c b/drivers/gpu/drm/amd/pm/legacy-dpm/si_smc.c
> similarity index 100%
> rename from drivers/gpu/drm/amd/pm/powerplay/si_smc.c
> rename to drivers/gpu/drm/amd/pm/legacy-dpm/si_smc.c
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/sislands_smc.h b/drivers/gpu/drm/amd/pm/legacy-dpm/sislands_smc.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/pm/powerplay/sislands_smc.h
> rename to drivers/gpu/drm/amd/pm/legacy-dpm/sislands_smc.h
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/Makefile b/drivers/gpu/drm/amd/pm/powerplay/Makefile
> index 614d8b6a58ad..795a3624cbbf 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/Makefile
> +++ b/drivers/gpu/drm/amd/pm/powerplay/Makefile
> @@ -28,11 +28,7 @@ AMD_POWERPLAY = $(addsuffix /Makefile,$(addprefix $(FULL_AMD_PATH)/pm/powerplay/
>   
>   include $(AMD_POWERPLAY)
>   
> -POWER_MGR-y = amd_powerplay.o legacy_dpm.o
> -
> -POWER_MGR-$(CONFIG_DRM_AMDGPU_CIK)+= kv_dpm.o kv_smc.o
> -
> -POWER_MGR-$(CONFIG_DRM_AMDGPU_SI)+= si_dpm.o si_smc.o
> +POWER_MGR-y = amd_powerplay.o
>   
>   AMD_PP_POWER = $(addprefix $(AMD_PP_PATH)/,$(POWER_MGR-y))
>   
> diff --git a/drivers/gpu/drm/amd/pm/inc/amd_powerplay.h b/drivers/gpu/drm/amd/pm/powerplay/inc/amd_powerplay.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/pm/inc/amd_powerplay.h
> rename to drivers/gpu/drm/amd/pm/powerplay/inc/amd_powerplay.h
> diff --git a/drivers/gpu/drm/amd/pm/inc/cz_ppsmc.h b/drivers/gpu/drm/amd/pm/powerplay/inc/cz_ppsmc.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/pm/inc/cz_ppsmc.h
> rename to drivers/gpu/drm/amd/pm/powerplay/inc/cz_ppsmc.h
> diff --git a/drivers/gpu/drm/amd/pm/inc/fiji_ppsmc.h b/drivers/gpu/drm/amd/pm/powerplay/inc/fiji_ppsmc.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/pm/inc/fiji_ppsmc.h
> rename to drivers/gpu/drm/amd/pm/powerplay/inc/fiji_ppsmc.h
> diff --git a/drivers/gpu/drm/amd/pm/inc/hardwaremanager.h b/drivers/gpu/drm/amd/pm/powerplay/inc/hardwaremanager.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/pm/inc/hardwaremanager.h
> rename to drivers/gpu/drm/amd/pm/powerplay/inc/hardwaremanager.h
> diff --git a/drivers/gpu/drm/amd/pm/inc/hwmgr.h b/drivers/gpu/drm/amd/pm/powerplay/inc/hwmgr.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/pm/inc/hwmgr.h
> rename to drivers/gpu/drm/amd/pm/powerplay/inc/hwmgr.h
> diff --git a/drivers/gpu/drm/amd/pm/inc/polaris10_pwrvirus.h b/drivers/gpu/drm/amd/pm/powerplay/inc/polaris10_pwrvirus.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/pm/inc/polaris10_pwrvirus.h
> rename to drivers/gpu/drm/amd/pm/powerplay/inc/polaris10_pwrvirus.h
> diff --git a/drivers/gpu/drm/amd/pm/inc/power_state.h b/drivers/gpu/drm/amd/pm/powerplay/inc/power_state.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/pm/inc/power_state.h
> rename to drivers/gpu/drm/amd/pm/powerplay/inc/power_state.h
> diff --git a/drivers/gpu/drm/amd/pm/inc/pp_debug.h b/drivers/gpu/drm/amd/pm/powerplay/inc/pp_debug.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/pm/inc/pp_debug.h
> rename to drivers/gpu/drm/amd/pm/powerplay/inc/pp_debug.h
> diff --git a/drivers/gpu/drm/amd/pm/inc/pp_endian.h b/drivers/gpu/drm/amd/pm/powerplay/inc/pp_endian.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/pm/inc/pp_endian.h
> rename to drivers/gpu/drm/amd/pm/powerplay/inc/pp_endian.h
> diff --git a/drivers/gpu/drm/amd/pm/inc/pp_thermal.h b/drivers/gpu/drm/amd/pm/powerplay/inc/pp_thermal.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/pm/inc/pp_thermal.h
> rename to drivers/gpu/drm/amd/pm/powerplay/inc/pp_thermal.h
> diff --git a/drivers/gpu/drm/amd/pm/inc/ppinterrupt.h b/drivers/gpu/drm/amd/pm/powerplay/inc/ppinterrupt.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/pm/inc/ppinterrupt.h
> rename to drivers/gpu/drm/amd/pm/powerplay/inc/ppinterrupt.h
> diff --git a/drivers/gpu/drm/amd/pm/inc/rv_ppsmc.h b/drivers/gpu/drm/amd/pm/powerplay/inc/rv_ppsmc.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/pm/inc/rv_ppsmc.h
> rename to drivers/gpu/drm/amd/pm/powerplay/inc/rv_ppsmc.h
> diff --git a/drivers/gpu/drm/amd/pm/inc/smu10.h b/drivers/gpu/drm/amd/pm/powerplay/inc/smu10.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/pm/inc/smu10.h
> rename to drivers/gpu/drm/amd/pm/powerplay/inc/smu10.h
> diff --git a/drivers/gpu/drm/amd/pm/inc/smu10_driver_if.h b/drivers/gpu/drm/amd/pm/powerplay/inc/smu10_driver_if.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/pm/inc/smu10_driver_if.h
> rename to drivers/gpu/drm/amd/pm/powerplay/inc/smu10_driver_if.h
> diff --git a/drivers/gpu/drm/amd/pm/inc/smu11_driver_if.h b/drivers/gpu/drm/amd/pm/powerplay/inc/smu11_driver_if.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/pm/inc/smu11_driver_if.h
> rename to drivers/gpu/drm/amd/pm/powerplay/inc/smu11_driver_if.h
> diff --git a/drivers/gpu/drm/amd/pm/inc/smu7.h b/drivers/gpu/drm/amd/pm/powerplay/inc/smu7.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/pm/inc/smu7.h
> rename to drivers/gpu/drm/amd/pm/powerplay/inc/smu7.h
> diff --git a/drivers/gpu/drm/amd/pm/inc/smu71.h b/drivers/gpu/drm/amd/pm/powerplay/inc/smu71.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/pm/inc/smu71.h
> rename to drivers/gpu/drm/amd/pm/powerplay/inc/smu71.h
> diff --git a/drivers/gpu/drm/amd/pm/inc/smu71_discrete.h b/drivers/gpu/drm/amd/pm/powerplay/inc/smu71_discrete.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/pm/inc/smu71_discrete.h
> rename to drivers/gpu/drm/amd/pm/powerplay/inc/smu71_discrete.h
> diff --git a/drivers/gpu/drm/amd/pm/inc/smu72.h b/drivers/gpu/drm/amd/pm/powerplay/inc/smu72.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/pm/inc/smu72.h
> rename to drivers/gpu/drm/amd/pm/powerplay/inc/smu72.h
> diff --git a/drivers/gpu/drm/amd/pm/inc/smu72_discrete.h b/drivers/gpu/drm/amd/pm/powerplay/inc/smu72_discrete.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/pm/inc/smu72_discrete.h
> rename to drivers/gpu/drm/amd/pm/powerplay/inc/smu72_discrete.h
> diff --git a/drivers/gpu/drm/amd/pm/inc/smu73.h b/drivers/gpu/drm/amd/pm/powerplay/inc/smu73.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/pm/inc/smu73.h
> rename to drivers/gpu/drm/amd/pm/powerplay/inc/smu73.h
> diff --git a/drivers/gpu/drm/amd/pm/inc/smu73_discrete.h b/drivers/gpu/drm/amd/pm/powerplay/inc/smu73_discrete.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/pm/inc/smu73_discrete.h
> rename to drivers/gpu/drm/amd/pm/powerplay/inc/smu73_discrete.h
> diff --git a/drivers/gpu/drm/amd/pm/inc/smu74.h b/drivers/gpu/drm/amd/pm/powerplay/inc/smu74.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/pm/inc/smu74.h
> rename to drivers/gpu/drm/amd/pm/powerplay/inc/smu74.h
> diff --git a/drivers/gpu/drm/amd/pm/inc/smu74_discrete.h b/drivers/gpu/drm/amd/pm/powerplay/inc/smu74_discrete.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/pm/inc/smu74_discrete.h
> rename to drivers/gpu/drm/amd/pm/powerplay/inc/smu74_discrete.h
> diff --git a/drivers/gpu/drm/amd/pm/inc/smu75.h b/drivers/gpu/drm/amd/pm/powerplay/inc/smu75.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/pm/inc/smu75.h
> rename to drivers/gpu/drm/amd/pm/powerplay/inc/smu75.h
> diff --git a/drivers/gpu/drm/amd/pm/inc/smu75_discrete.h b/drivers/gpu/drm/amd/pm/powerplay/inc/smu75_discrete.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/pm/inc/smu75_discrete.h
> rename to drivers/gpu/drm/amd/pm/powerplay/inc/smu75_discrete.h
> diff --git a/drivers/gpu/drm/amd/pm/inc/smu7_common.h b/drivers/gpu/drm/amd/pm/powerplay/inc/smu7_common.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/pm/inc/smu7_common.h
> rename to drivers/gpu/drm/amd/pm/powerplay/inc/smu7_common.h
> diff --git a/drivers/gpu/drm/amd/pm/inc/smu7_discrete.h b/drivers/gpu/drm/amd/pm/powerplay/inc/smu7_discrete.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/pm/inc/smu7_discrete.h
> rename to drivers/gpu/drm/amd/pm/powerplay/inc/smu7_discrete.h
> diff --git a/drivers/gpu/drm/amd/pm/inc/smu7_fusion.h b/drivers/gpu/drm/amd/pm/powerplay/inc/smu7_fusion.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/pm/inc/smu7_fusion.h
> rename to drivers/gpu/drm/amd/pm/powerplay/inc/smu7_fusion.h
> diff --git a/drivers/gpu/drm/amd/pm/inc/smu7_ppsmc.h b/drivers/gpu/drm/amd/pm/powerplay/inc/smu7_ppsmc.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/pm/inc/smu7_ppsmc.h
> rename to drivers/gpu/drm/amd/pm/powerplay/inc/smu7_ppsmc.h
> diff --git a/drivers/gpu/drm/amd/pm/inc/smu8.h b/drivers/gpu/drm/amd/pm/powerplay/inc/smu8.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/pm/inc/smu8.h
> rename to drivers/gpu/drm/amd/pm/powerplay/inc/smu8.h
> diff --git a/drivers/gpu/drm/amd/pm/inc/smu8_fusion.h b/drivers/gpu/drm/amd/pm/powerplay/inc/smu8_fusion.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/pm/inc/smu8_fusion.h
> rename to drivers/gpu/drm/amd/pm/powerplay/inc/smu8_fusion.h
> diff --git a/drivers/gpu/drm/amd/pm/inc/smu9.h b/drivers/gpu/drm/amd/pm/powerplay/inc/smu9.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/pm/inc/smu9.h
> rename to drivers/gpu/drm/amd/pm/powerplay/inc/smu9.h
> diff --git a/drivers/gpu/drm/amd/pm/inc/smu9_driver_if.h b/drivers/gpu/drm/amd/pm/powerplay/inc/smu9_driver_if.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/pm/inc/smu9_driver_if.h
> rename to drivers/gpu/drm/amd/pm/powerplay/inc/smu9_driver_if.h
> diff --git a/drivers/gpu/drm/amd/pm/inc/smu_ucode_xfer_cz.h b/drivers/gpu/drm/amd/pm/powerplay/inc/smu_ucode_xfer_cz.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/pm/inc/smu_ucode_xfer_cz.h
> rename to drivers/gpu/drm/amd/pm/powerplay/inc/smu_ucode_xfer_cz.h
> diff --git a/drivers/gpu/drm/amd/pm/inc/smu_ucode_xfer_vi.h b/drivers/gpu/drm/amd/pm/powerplay/inc/smu_ucode_xfer_vi.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/pm/inc/smu_ucode_xfer_vi.h
> rename to drivers/gpu/drm/amd/pm/powerplay/inc/smu_ucode_xfer_vi.h
> diff --git a/drivers/gpu/drm/amd/pm/inc/smumgr.h b/drivers/gpu/drm/amd/pm/powerplay/inc/smumgr.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/pm/inc/smumgr.h
> rename to drivers/gpu/drm/amd/pm/powerplay/inc/smumgr.h
> diff --git a/drivers/gpu/drm/amd/pm/inc/tonga_ppsmc.h b/drivers/gpu/drm/amd/pm/powerplay/inc/tonga_ppsmc.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/pm/inc/tonga_ppsmc.h
> rename to drivers/gpu/drm/amd/pm/powerplay/inc/tonga_ppsmc.h
> diff --git a/drivers/gpu/drm/amd/pm/inc/vega10_ppsmc.h b/drivers/gpu/drm/amd/pm/powerplay/inc/vega10_ppsmc.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/pm/inc/vega10_ppsmc.h
> rename to drivers/gpu/drm/amd/pm/powerplay/inc/vega10_ppsmc.h
> diff --git a/drivers/gpu/drm/amd/pm/inc/vega12/smu9_driver_if.h b/drivers/gpu/drm/amd/pm/powerplay/inc/vega12/smu9_driver_if.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/pm/inc/vega12/smu9_driver_if.h
> rename to drivers/gpu/drm/amd/pm/powerplay/inc/vega12/smu9_driver_if.h
> diff --git a/drivers/gpu/drm/amd/pm/inc/vega12_ppsmc.h b/drivers/gpu/drm/amd/pm/powerplay/inc/vega12_ppsmc.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/pm/inc/vega12_ppsmc.h
> rename to drivers/gpu/drm/amd/pm/powerplay/inc/vega12_ppsmc.h
> diff --git a/drivers/gpu/drm/amd/pm/inc/vega20_ppsmc.h b/drivers/gpu/drm/amd/pm/powerplay/inc/vega20_ppsmc.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/pm/inc/vega20_ppsmc.h
> rename to drivers/gpu/drm/amd/pm/powerplay/inc/vega20_ppsmc.h
> diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
> rename to drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> diff --git a/drivers/gpu/drm/amd/pm/inc/smu11_driver_if_arcturus.h b/drivers/gpu/drm/amd/pm/swsmu/inc/interface/smu11_driver_if_arcturus.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/pm/inc/smu11_driver_if_arcturus.h
> rename to drivers/gpu/drm/amd/pm/swsmu/inc/interface/smu11_driver_if_arcturus.h
> diff --git a/drivers/gpu/drm/amd/pm/inc/smu11_driver_if_cyan_skillfish.h b/drivers/gpu/drm/amd/pm/swsmu/inc/interface/smu11_driver_if_cyan_skillfish.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/pm/inc/smu11_driver_if_cyan_skillfish.h
> rename to drivers/gpu/drm/amd/pm/swsmu/inc/interface/smu11_driver_if_cyan_skillfish.h
> diff --git a/drivers/gpu/drm/amd/pm/inc/smu11_driver_if_navi10.h b/drivers/gpu/drm/amd/pm/swsmu/inc/interface/smu11_driver_if_navi10.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/pm/inc/smu11_driver_if_navi10.h
> rename to drivers/gpu/drm/amd/pm/swsmu/inc/interface/smu11_driver_if_navi10.h
> diff --git a/drivers/gpu/drm/amd/pm/inc/smu11_driver_if_sienna_cichlid.h b/drivers/gpu/drm/amd/pm/swsmu/inc/interface/smu11_driver_if_sienna_cichlid.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/pm/inc/smu11_driver_if_sienna_cichlid.h
> rename to drivers/gpu/drm/amd/pm/swsmu/inc/interface/smu11_driver_if_sienna_cichlid.h
> diff --git a/drivers/gpu/drm/amd/pm/inc/smu11_driver_if_vangogh.h b/drivers/gpu/drm/amd/pm/swsmu/inc/interface/smu11_driver_if_vangogh.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/pm/inc/smu11_driver_if_vangogh.h
> rename to drivers/gpu/drm/amd/pm/swsmu/inc/interface/smu11_driver_if_vangogh.h
> diff --git a/drivers/gpu/drm/amd/pm/inc/smu12_driver_if.h b/drivers/gpu/drm/amd/pm/swsmu/inc/interface/smu12_driver_if.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/pm/inc/smu12_driver_if.h
> rename to drivers/gpu/drm/amd/pm/swsmu/inc/interface/smu12_driver_if.h
> diff --git a/drivers/gpu/drm/amd/pm/inc/smu13_driver_if_aldebaran.h b/drivers/gpu/drm/amd/pm/swsmu/inc/interface/smu13_driver_if_aldebaran.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/pm/inc/smu13_driver_if_aldebaran.h
> rename to drivers/gpu/drm/amd/pm/swsmu/inc/interface/smu13_driver_if_aldebaran.h
> diff --git a/drivers/gpu/drm/amd/pm/inc/smu13_driver_if_yellow_carp.h b/drivers/gpu/drm/amd/pm/swsmu/inc/interface/smu13_driver_if_yellow_carp.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/pm/inc/smu13_driver_if_yellow_carp.h
> rename to drivers/gpu/drm/amd/pm/swsmu/inc/interface/smu13_driver_if_yellow_carp.h
> diff --git a/drivers/gpu/drm/amd/pm/inc/smu_v11_5_pmfw.h b/drivers/gpu/drm/amd/pm/swsmu/inc/interface/smu_v11_5_pmfw.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/pm/inc/smu_v11_5_pmfw.h
> rename to drivers/gpu/drm/amd/pm/swsmu/inc/interface/smu_v11_5_pmfw.h
> diff --git a/drivers/gpu/drm/amd/pm/inc/smu_v11_8_pmfw.h b/drivers/gpu/drm/amd/pm/swsmu/inc/interface/smu_v11_8_pmfw.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/pm/inc/smu_v11_8_pmfw.h
> rename to drivers/gpu/drm/amd/pm/swsmu/inc/interface/smu_v11_8_pmfw.h
> diff --git a/drivers/gpu/drm/amd/pm/inc/smu_v13_0_1_pmfw.h b/drivers/gpu/drm/amd/pm/swsmu/inc/interface/smu_v13_0_1_pmfw.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/pm/inc/smu_v13_0_1_pmfw.h
> rename to drivers/gpu/drm/amd/pm/swsmu/inc/interface/smu_v13_0_1_pmfw.h
> diff --git a/drivers/gpu/drm/amd/pm/inc/aldebaran_ppsmc.h b/drivers/gpu/drm/amd/pm/swsmu/inc/message/aldebaran_ppsmc.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/pm/inc/aldebaran_ppsmc.h
> rename to drivers/gpu/drm/amd/pm/swsmu/inc/message/aldebaran_ppsmc.h
> diff --git a/drivers/gpu/drm/amd/pm/inc/arcturus_ppsmc.h b/drivers/gpu/drm/amd/pm/swsmu/inc/message/arcturus_ppsmc.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/pm/inc/arcturus_ppsmc.h
> rename to drivers/gpu/drm/amd/pm/swsmu/inc/message/arcturus_ppsmc.h
> diff --git a/drivers/gpu/drm/amd/pm/inc/smu_v11_0_7_ppsmc.h b/drivers/gpu/drm/amd/pm/swsmu/inc/message/smu_v11_0_7_ppsmc.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/pm/inc/smu_v11_0_7_ppsmc.h
> rename to drivers/gpu/drm/amd/pm/swsmu/inc/message/smu_v11_0_7_ppsmc.h
> diff --git a/drivers/gpu/drm/amd/pm/inc/smu_v11_0_ppsmc.h b/drivers/gpu/drm/amd/pm/swsmu/inc/message/smu_v11_0_ppsmc.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/pm/inc/smu_v11_0_ppsmc.h
> rename to drivers/gpu/drm/amd/pm/swsmu/inc/message/smu_v11_0_ppsmc.h
> diff --git a/drivers/gpu/drm/amd/pm/inc/smu_v11_5_ppsmc.h b/drivers/gpu/drm/amd/pm/swsmu/inc/message/smu_v11_5_ppsmc.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/pm/inc/smu_v11_5_ppsmc.h
> rename to drivers/gpu/drm/amd/pm/swsmu/inc/message/smu_v11_5_ppsmc.h
> diff --git a/drivers/gpu/drm/amd/pm/inc/smu_v11_8_ppsmc.h b/drivers/gpu/drm/amd/pm/swsmu/inc/message/smu_v11_8_ppsmc.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/pm/inc/smu_v11_8_ppsmc.h
> rename to drivers/gpu/drm/amd/pm/swsmu/inc/message/smu_v11_8_ppsmc.h
> diff --git a/drivers/gpu/drm/amd/pm/inc/smu_v12_0_ppsmc.h b/drivers/gpu/drm/amd/pm/swsmu/inc/message/smu_v12_0_ppsmc.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/pm/inc/smu_v12_0_ppsmc.h
> rename to drivers/gpu/drm/amd/pm/swsmu/inc/message/smu_v12_0_ppsmc.h
> diff --git a/drivers/gpu/drm/amd/pm/inc/smu_v13_0_1_ppsmc.h b/drivers/gpu/drm/amd/pm/swsmu/inc/message/smu_v13_0_1_ppsmc.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/pm/inc/smu_v13_0_1_ppsmc.h
> rename to drivers/gpu/drm/amd/pm/swsmu/inc/message/smu_v13_0_1_ppsmc.h
> diff --git a/drivers/gpu/drm/amd/pm/inc/smu_11_0_cdr_table.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_11_0_cdr_table.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/pm/inc/smu_11_0_cdr_table.h
> rename to drivers/gpu/drm/amd/pm/swsmu/inc/smu_11_0_cdr_table.h
> diff --git a/drivers/gpu/drm/amd/pm/inc/smu_types.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/pm/inc/smu_types.h
> rename to drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
> diff --git a/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v11_0.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
> rename to drivers/gpu/drm/amd/pm/swsmu/inc/smu_v11_0.h
> diff --git a/drivers/gpu/drm/amd/pm/inc/smu_v11_0_7_pptable.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v11_0_7_pptable.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/pm/inc/smu_v11_0_7_pptable.h
> rename to drivers/gpu/drm/amd/pm/swsmu/inc/smu_v11_0_7_pptable.h
> diff --git a/drivers/gpu/drm/amd/pm/inc/smu_v11_0_pptable.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v11_0_pptable.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/pm/inc/smu_v11_0_pptable.h
> rename to drivers/gpu/drm/amd/pm/swsmu/inc/smu_v11_0_pptable.h
> diff --git a/drivers/gpu/drm/amd/pm/inc/smu_v12_0.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v12_0.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/pm/inc/smu_v12_0.h
> rename to drivers/gpu/drm/amd/pm/swsmu/inc/smu_v12_0.h
> diff --git a/drivers/gpu/drm/amd/pm/inc/smu_v13_0.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/pm/inc/smu_v13_0.h
> rename to drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
> diff --git a/drivers/gpu/drm/amd/pm/inc/smu_v13_0_pptable.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0_pptable.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/pm/inc/smu_v13_0_pptable.h
> rename to drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0_pptable.h
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
> index a03bbd2a7aa0..1e6d76657bbb 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
> @@ -33,7 +33,6 @@
>   #include "smu11_driver_if_arcturus.h"
>   #include "soc15_common.h"
>   #include "atom.h"
> -#include "power_state.h"
>   #include "arcturus_ppt.h"
>   #include "smu_v11_0_pptable.h"
>   #include "arcturus_ppsmc.h"
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
> index 3c82f5455f88..cc502a35f9ef 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
> @@ -33,7 +33,6 @@
>   #include "smu13_driver_if_aldebaran.h"
>   #include "soc15_common.h"
>   #include "atom.h"
> -#include "power_state.h"
>   #include "aldebaran_ppt.h"
>   #include "smu_v13_0_pptable.h"
>   #include "aldebaran_ppsmc.h"
> 
