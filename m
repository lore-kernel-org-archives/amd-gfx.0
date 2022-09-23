Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E17EC6FA82
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Sep 2022 14:05:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6D03610E578;
	Fri, 23 Sep 2022 14:05:48 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2857F10E56C
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Sep 2022 14:05:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lCRE3oeR9sGVloemmljvxFF8f8Ysx9fUYQsD+hMxtI0Eikg5ICKEgIOc3KQx7tTkE8182B+PEnQep0n/9bcbXYcxCLOD07gmQoToEqUnnYFvdR7ITyP0ubkytnVe4f8VPkxe2kBor50ZYd48Pc79eP2yXE9WQbDgKPJv3QsEllQtxNy58cr7bJP591I93VD3ZaeMxEm1pyZ3Jf9MOWlDhWHs+VHxsRk51nCvTpacpWFFo+tytKat+N7zBEsiXS8GnmctrsCFhf3Toj7o8RbI4TXojptRUFM/Cgx1KxqymZlHQe59/6i0Ww7NbEhoICzMAjchORQ5x2+AjAkY3NZgTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p2573TFIcgbtcaYp3UofeATjKQHJqDqSUTdyTMpMaGQ=;
 b=Z/HqJJd6IeNb+roGXW+ndfVOlA4QQUk82IpKBeDPyxVqbtuREThJqI4iF8QtRLXfu5lJoLjBkOoenwIfjSAaoVlhHtiVweV3NcLScAlQWGqoahXCMudlFUfxEEJIUTISSW+txR+pffTPrULxY8k/FHBoeyU1UehTIsvdj8EWHE32NEjoRArgcPQKCn5tblJRRaz+qmNInDafWowAXg6QWV6u/82Q0RSN3JqlELELyl7zg0sOyWFaKKBIAtlsyiJF8E6Fp1pd6T3A2bvdD+XXq1roe8iFRtnF1bDjtlF9EEW99eJwdepTEHZU5xJTlbQ/i5IWeGlTa+4WgoZOh8OeYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p2573TFIcgbtcaYp3UofeATjKQHJqDqSUTdyTMpMaGQ=;
 b=kAgEHc4mBCO/PY5uNzwIHqvViFzBh6YhbOjrY3Lz6NkPJ0cKZ/n4Hfu49wI7/8u/ojQCTeFnXxllAXi62B6jV6HIot3qCjsG21q5oaYyJEX8C8xTowpdNNe1HdTN6DZSbp8olZ2Gc7iYy5Kg5VOFJzG6TPDrn7NToMKDQc2Cq3o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM8PR12MB5399.namprd12.prod.outlook.com (2603:10b6:8:34::5) by
 MW3PR12MB4556.namprd12.prod.outlook.com (2603:10b6:303:52::20) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5654.20; Fri, 23 Sep 2022 14:05:39 +0000
Received: from DM8PR12MB5399.namprd12.prod.outlook.com
 ([fe80::c2e0:7000:9e70:e2fa]) by DM8PR12MB5399.namprd12.prod.outlook.com
 ([fe80::c2e0:7000:9e70:e2fa%4]) with mapi id 15.20.5632.019; Fri, 23 Sep 2022
 14:05:39 +0000
Message-ID: <539ae58d-79f9-4bce-4e93-679e09303288@amd.com>
Date: Fri, 23 Sep 2022 10:05:36 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] drm/amdgpu/vcn: update vcn4 fw shared data structure
Content-Language: en-US
To: Ruijing Dong <ruijing.dong@amd.com>, Christian.Koenig@amd.com,
 james.zhu@amd.com, boyuan.zhang@amd.com, sonny.jiang@amd.com,
 amd-gfx@lists.freedesktop.org
References: <20220922193042.35427-1-ruijing.dong@amd.com>
From: Leo Liu <leo.liu@amd.com>
In-Reply-To: <20220922193042.35427-1-ruijing.dong@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT2PR01CA0022.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:38::27) To DM8PR12MB5399.namprd12.prod.outlook.com
 (2603:10b6:8:34::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR12MB5399:EE_|MW3PR12MB4556:EE_
X-MS-Office365-Filtering-Correlation-Id: ab5f313d-721b-4f6c-5f3b-08da9d6cb1a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: X13D1JnKOhhumR8AC7BQogBvq9dxl0LFsKgNRutTARcJyqq6v5D9gzqGRKjkK7V03LfsaT7bxgVVsvisnU1ieuwZ63hTAT+Jy8icZZgEGX83YT/NfnKl1pOnG0o4PDB1vKidobexuAOjcaafL5Fw16+haaIl98JB77GDpPzRhUntk/I/H5KhwPGgr5C/4OdPi9OxJlWT7eHpjG3udsmSbafiDEICpP9+zcDXAmg232fw92mjbzqAD0uDu4SuLSwdGSY9GWWVgRcXVIxIeEo4ihGS2Dxf4o+Xm7za32i2uQpPsHZtzVaH5/I7YWyhs9bXF6dv2rUQontZmYOsvHv1XHssyd+DeO8LX/vmS4IEXLvT9VVdmAVi3QELQ18il7+B3mVK4mL5DFnn+Rx8lxRRsYvVa4me+VBa9HDJOjeZLstYFmut0AHY1DVNa+R12081+c57+k5aPS814PYsRKRmd7ostkDxhdwvBXpfSkiYTufDt6JCN6A9AgE2YvU0dBr/zgg3waolnaiqwBbmn4A2/VvG1UaKoEb8AWvFrfaHG9y627NQFy/pW63jBaPIRS/TqDhQkiCOCpfnn40jk+wa2qP+89kjgxvMG2k8r7K4BMiTL6SRhfCENnhSvRmr0WRLhrH9Zq2I5FXQ9AqFHggy2qCC2T1EJ0mIxf9llAvvfyFoMa3k9l3a4iNT9JWZ1sZ6WmNhggxRpmVWCrgjlkjAtWnK5XzATjilRegcr332xX9L2rm3CM+olFKUevcl0ljcXqoPOeoiJnvc0VgYxcssBiSjXo4ZtZGKx8OF1ip9H0A=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM8PR12MB5399.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(376002)(366004)(39860400002)(136003)(346002)(451199015)(31686004)(44832011)(5660300002)(6486002)(86362001)(38100700002)(186003)(8676002)(2906002)(31696002)(478600001)(83380400001)(316002)(15650500001)(8936002)(26005)(6512007)(53546011)(66476007)(6506007)(66556008)(66946007)(4326008)(2616005)(36756003)(41300700001)(6666004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S2dxM0ZPZnovMm5OcGNhYVFMS2o5aGt4TzVCZE9pU2JuU2FjQ0k0RkhjWGVw?=
 =?utf-8?B?R2hIbWxlVUlMVTRGU2NycXlTVHBoZjcxZ1dEV0tUOGZWaTJyREhoZDFoKysv?=
 =?utf-8?B?WHNESzJWdGUxYnk5M3h4V3JOY21OOEwzeTVsbGtXNlFJU0NWQml6Ui80U09z?=
 =?utf-8?B?OTVQTmxKWS9NMitTR2VKYUN6QjJNeDRTcldNaXRzTEhmbVUzcFlPZmx5STBz?=
 =?utf-8?B?ZC9lclZGditQaytnMVVCcDRpeEo5N2ZiZVRpTTN4eUFoT3NTWjhudnA2bnk3?=
 =?utf-8?B?dWFjQURBMnY4MVF3cUFrY2ovSHREY0t6azljb0FTRVF0Y0xKTCtnaWFPZmJo?=
 =?utf-8?B?M1RYakI3KzUzUGl0VkMyMVFJQzg1cWtqSStqNml1Q0xxVXFlNGNKSi9wVml0?=
 =?utf-8?B?UnRmcFNJbjRCcHNLNXdJcm1DV3pKcmx5YkhpVUs2aHp4MjUrbk52M2lEU2RJ?=
 =?utf-8?B?KzlRb0FBTXRkenBqZTBEUGhFQm5GODMxY0xNNW53LzNZeEtFSWdWc2dmKzZF?=
 =?utf-8?B?R3A0K3J4bjQwQjEvMW5vc3ZJMi9DTWQ1UXNML1Nnc0xRYUFsaDJmK2MwMDZj?=
 =?utf-8?B?aVgzNXo2WUIzdG44NDh5MldnL3UyL0V2VXBLV1R3WEgwUHZxUmtZa09uOXhI?=
 =?utf-8?B?S3orWUtGMytFMUNSUTBPQ1VHTHRoc0tPbWxHeHdDSjB5RG5vTm12YmJqWnVr?=
 =?utf-8?B?VEdVTTdTdWtETFNYZzJuV0s2NUlrMWhyRkZTamRKQVVnUlFzR0FkNSttbmQ0?=
 =?utf-8?B?YzBtRnJnSWFFVGpNUDV6Um9CanJGWDJKZDd6QU1HWlJrUm1ja1RUNGRBL0hk?=
 =?utf-8?B?b1UwaHVuMUswbmJHVUo3SmNkbUh0UTVVemYwejZlanlXK3lhU1UxZDN2RE1P?=
 =?utf-8?B?WGwxeEU5eWtHaHcvRC9Gb21xTkVlcU1vZFoxRXdhR2gzczhhU1ppZEViOEtp?=
 =?utf-8?B?eXZTNUwvbWRsZS9xalZFTGFzZTdienp4VkkzODFrWXpjSUdoMVlPTXdNeDkv?=
 =?utf-8?B?cmRtYzQyemZNanp5TXhYNHd6QW51eXN2ZFJIMXNRaE40TkRpOTdGSEpBc0tP?=
 =?utf-8?B?cUpDVDF5cE1wb242YmZnQUtqQWhnelhmZ0NIRmdzWjlUS3ozSWl5clYwOTlD?=
 =?utf-8?B?NUx3TFdOQVZFYmd6MUxXYVpQVW16NkRaemoycUcxbHZ2VndLQ1dwdFpRMmRk?=
 =?utf-8?B?a3VnbXBzcmtVUjE1alcxQUdPVXlzOFlxUkl6cEgrU0J3TW95R2I4eFJEZ0xZ?=
 =?utf-8?B?QXdxVkFnWjNaQ0NLTHZxRnpsOFV3cXZ4c3Znb2lpQWtUSHBwVmsrVERBSk82?=
 =?utf-8?B?MjRPZWZXMDJNSE5Sc3A4R1Z6RUllQW90SXJRbXlOSmVHWUp3REdOaS81WTIz?=
 =?utf-8?B?cmc0SE9xa1doazUvZVJiZmM3Qy9KUGhTTzJuYkMyUWtIb3pDY1gzQWhQSElu?=
 =?utf-8?B?MlVTRmt4TEsrQ2RRdldQZGlKWWgwL2E1ZTQ4SmJUNmVucXNnZGVhQjJwQnBn?=
 =?utf-8?B?bHpmZ0lURlNtRGxUV2xsU0ZxVWJ0WXF3Z3V3T2ZKbjdRbGRBMGVYa0xreU82?=
 =?utf-8?B?bWR6SnBjVHBqUUhYeXBFenZHWGlLUnM1L2NLNVhMRTFtZzMrcHI5VnhlQUlv?=
 =?utf-8?B?dytCaUd6QlVNdktVb2RlVjFEdS9ZREJpRUIrK002UkxGWTE3Nmc3UTVneGEr?=
 =?utf-8?B?VHZpeDBmV1BXYy83Qis3QWN2V3l3d2lHNnJZdGhlTXdKc01KazNDL1hGc2d0?=
 =?utf-8?B?cGNVemlxZDFFRmZQYU9jV1k2VWpiRGxJVDQ3SW1yZlA3VkJ4RDF0ZlRFTDEw?=
 =?utf-8?B?SktHSlRqZmwvbEwrMEFVZ096Y1FaK0NZeElzT05vWGo3RHRuVnhKQmw5ZUVJ?=
 =?utf-8?B?QVB4NWJRSjNoK2tnRzZER1Y1Zkl2bmNnMTk5V0ZZcytKY2Q2THFUYzRQTDQ5?=
 =?utf-8?B?V3c5OVVXQTJLckpKSzZpaVRsR3lsSmpObC92cXQzaWVxdGlrMVRWM2k2RHFO?=
 =?utf-8?B?UVhJWmZIOEV2MWdSbDJyemxBL3NidGN4cHpuM0NtaWllVVZGRlJIVXd5cHpN?=
 =?utf-8?B?QWtwa2RyWEtlM043TDh6VnBlaXMxTTh1aTVJbytwNXNSNHNpd0VmMEhYT1dY?=
 =?utf-8?Q?8x3Z4lzKZCeIrRU8yflpvIUqx?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab5f313d-721b-4f6c-5f3b-08da9d6cb1a4
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5399.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2022 14:05:39.0120 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QSacJHRWxJM8AZyBU2gE2X/cObs1w1TzXfm+W9YFgGVD6qmWh4EjL9u3l6hIUbFA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4556
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

Reviewed-by: Leo Liu <leo.liu@amd.com>

On 2022-09-22 15:30, Ruijing Dong wrote:
> update VF_RB_SETUP_FLAG, add SMU_DPM_INTERFACE_FLAG,
> and corresponding change in VCN4.
>
> Signed-off-by: Ruijing Dong <ruijing.dong@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h | 8 +++++++-
>   drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c   | 4 ++++
>   2 files changed, 11 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> index 80b7a6cfd026..253ea6b159df 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> @@ -161,7 +161,8 @@
>   #define AMDGPU_VCN_SW_RING_FLAG		(1 << 9)
>   #define AMDGPU_VCN_FW_LOGGING_FLAG	(1 << 10)
>   #define AMDGPU_VCN_SMU_VERSION_INFO_FLAG (1 << 11)
> -#define AMDGPU_VCN_VF_RB_SETUP_FLAG (1 << 12)
> +#define AMDGPU_VCN_SMU_DPM_INTERFACE_FLAG (1 << 11)
> +#define AMDGPU_VCN_VF_RB_SETUP_FLAG (1 << 14)
>   
>   #define AMDGPU_VCN_IB_FLAG_DECODE_BUFFER	0x00000001
>   #define AMDGPU_VCN_CMD_FLAG_MSG_BUFFER		0x00000001
> @@ -171,6 +172,9 @@
>   #define VCN_CODEC_DISABLE_MASK_HEVC (1 << 2)
>   #define VCN_CODEC_DISABLE_MASK_H264 (1 << 3)
>   
> +#define AMDGPU_VCN_SMU_DPM_INTERFACE_DGPU (0)
> +#define AMDGPU_VCN_SMU_DPM_INTERFACE_APU (1)
> +
>   enum fw_queue_mode {
>   	FW_QUEUE_RING_RESET = 1,
>   	FW_QUEUE_DPG_HOLD_OFF = 2,
> @@ -335,7 +339,9 @@ struct amdgpu_vcn4_fw_shared {
>   	struct amdgpu_fw_shared_unified_queue_struct sq;
>   	uint8_t pad1[8];
>   	struct amdgpu_fw_shared_fw_logging fw_log;
> +	uint8_t pad2[20];
>   	struct amdgpu_fw_shared_rb_setup rb_setup;
> +	struct amdgpu_fw_shared_smu_interface_info smu_dpm_interface;
>   };
>   
>   struct amdgpu_vcn_fwlog {
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> index b6f73b87c47e..897a5ce9c9da 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> @@ -150,6 +150,10 @@ static int vcn_v4_0_sw_init(void *handle)
>   		fw_shared->present_flag_0 = cpu_to_le32(AMDGPU_FW_SHARED_FLAG_0_UNIFIED_QUEUE);
>   		fw_shared->sq.is_enabled = 1;
>   
> +		fw_shared->present_flag_0 |= cpu_to_le32(AMDGPU_VCN_SMU_DPM_INTERFACE_FLAG);
> +		fw_shared->smu_dpm_interface.smu_interface_type = (adev->flags & AMD_IS_APU) ?
> +			AMDGPU_VCN_SMU_DPM_INTERFACE_APU : AMDGPU_VCN_SMU_DPM_INTERFACE_DGPU;
> +
>   		if (amdgpu_sriov_vf(adev))
>   			fw_shared->present_flag_0 |= cpu_to_le32(AMDGPU_VCN_VF_RB_SETUP_FLAG);
>   
