Return-Path: <SRS0=sE/Q=OU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3A49C433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Sep 2021 13:33:02 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B0C8615E2
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Sep 2021 13:33:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9B0C8615E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EE5326EB8E;
	Thu, 30 Sep 2021 13:33:01 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2062.outbound.protection.outlook.com [40.107.243.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CAD476EB8E
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Sep 2021 13:33:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JxMVaME2nBoX7lAluOquuwatieq9an1eBGti11pipvkTlitLf+V8yudi5jfBlS1tr8bZzqsGLZEPZS6Ivga5oj/LMmMBrO+TgdCMfjSmojBZwFYFKhnu4ZTf7OzBgs12MYBsPk2fjOWEz2OPjH3lzIQaimq9m0WV5IM74SBlGMnUDfYTryWED8HhIiH8171gCxllRW24P5NfRJ4rzKA7Dj2BZOpaZTjeMgr/m1lDvRJYsUbxmBT7HcR8xk3bngWOOX5/xsC0JXIshdpfq14L9987CVMJhfCsO8SRDVlEQmPuUClQ00PwtESFfoBmtp5xTMOLp4SfL4MWZ1m3fzm/RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=Bso9vcrHKV4VPe4lmW3VdknN/B9KkqtXVS0ZU5uzqnM=;
 b=Kk+OrqjlWYx597YJIsW5ywngNROdvyfZ+/XOR2J9010dzsxfqUJ6iZTvbztW69wUZs2iGPz5UG0TBH+O5Y9l41XLYNvkzk+eQpUclgfW1v021I16koCUCfCR8ASuqjhZXR8xdhZdsJnzISpGblxRxeJsAEyL/xGikx/gSNg1sHoE2LRjkfQ6qd+k9tUVlv2t0F8thU2jy+Zi+L9U4S9N0rwEWZUnCcIchjTx4WbEO5xfeWutmuEmj+yg7xJpnThFqMNkBG0wiMlfdprh43dDi9QkXpAF0GHSwZxLfXhvYQSnHiz96sK9JpfmUAYi6DWtQr/QIrGNrAXHtioc5zmO1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bso9vcrHKV4VPe4lmW3VdknN/B9KkqtXVS0ZU5uzqnM=;
 b=oyQT/jKiB/ucpJSkuQMttJexIlvG0psCuyQvol0pgNIZYzHss9nrdhlfjWSOleHRdzc/fykHRAuNuGSMueygeJStfGFfZ0y/gX3BDVJDrXJaWFzr+eGwjyzFuiTAV/JUHD++15VTrNzM5Ox4TFu5B/zA6MqyX0621pjfOnNe3kI=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM8PR12MB5399.namprd12.prod.outlook.com (2603:10b6:8:34::5) by
 DM8PR12MB5400.namprd12.prod.outlook.com (2603:10b6:8:3b::12) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4544.14; Thu, 30 Sep 2021 13:32:58 +0000
Received: from DM8PR12MB5399.namprd12.prod.outlook.com
 ([fe80::601a:855c:7c9e:220b]) by DM8PR12MB5399.namprd12.prod.outlook.com
 ([fe80::601a:855c:7c9e:220b%7]) with mapi id 15.20.4566.014; Thu, 30 Sep 2021
 13:32:58 +0000
Subject: Re: [PATCH 1/2] drm/amdgpu/jpeg2: move jpeg2 shared macro to header
 file
To: James Zhu <James.Zhu@amd.com>, amd-gfx@lists.freedesktop.org
Cc: jamesz@amd.com
References: <1632945429-7902-1-git-send-email-James.Zhu@amd.com>
From: Leo Liu <leo.liu@amd.com>
Message-ID: <317bd6c1-5974-37e1-7994-59fb58b627fc@amd.com>
Date: Thu, 30 Sep 2021 09:32:46 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <1632945429-7902-1-git-send-email-James.Zhu@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: YTOPR0101CA0034.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:15::47) To DM8PR12MB5399.namprd12.prod.outlook.com
 (2603:10b6:8:34::5)
MIME-Version: 1.0
Received: from [192.168.68.78] (173.35.226.30) by
 YTOPR0101CA0034.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:15::47) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.14 via Frontend
 Transport; Thu, 30 Sep 2021 13:32:58 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1895f9fe-5d9a-4df1-281a-08d98416d15e
X-MS-TrafficTypeDiagnostic: DM8PR12MB5400:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM8PR12MB5400CC2FD97FFF00864783DDE5AA9@DM8PR12MB5400.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:346;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9vQEuEf+ZArF/AEEnEhq7bL3qk9+f+z6nv3mEVDNHlWDb7u2FFq34krhyl4Y9grjd7r785SKntebABJ4NZif+EVX8UtV0my6qXa8ODe2aCl9QDtQ/b5fLNyrRcCH8qeomQgLODSmZmKcKKVth7yBQ3MS71ynwQw4jYmeLvguXyx+Lfy1VxXgJieE44YlmuSxFx85/OxuW7gy8dCAqe3kZiqdZSd17GEe0K6VN9tbcH4/ZdTIVtTHEecuhUd8uLPKSfRb2nfI/dsZ+gglN+wJSZ5P4d3C0vi1u6RkzOdx051N0U2OC9GzOHnhWz3TMRBh/keqMgscfyVirR8yYtXZNQoZ8zfnamy3Hgf1c7ffEb1sUInl3InsdlOW2kKUKmUmGIc9HUfT0aJiZiy8SBuVIq6dWOOSYKoFYCVdCJhyStDcTkNir4lyb7PL0/bWetGo1w63tu/FzWvmGKWPgYwKnGkHhjZThauNIznHFohIU3L0vN7Ia3vZP4JaLX6Xr9cg88I33PGh/mvCLp/lMdkpxM1uwlk6oLM6L+2u+pQWz5bJXLAEMbGE7+KJwsNV9qwasy5Yzp4fMYFGcvl+ifxIIMRYQnXL/qbuT7VWDADV4OgVm1/POxci2taUVm2f8LRPFUWVNDMrmSJXDVK6Pb+iDJbzUUAjLtXB4XzkORZWgVI0NFmiFHlHwSjfP3iDwWogX9lZ/iD2vDW5hMoqZSPMh/h9Tp+zK2/bq9up1o8BqGY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM8PR12MB5399.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(86362001)(508600001)(66556008)(66476007)(16576012)(36756003)(83380400001)(2906002)(66946007)(316002)(31686004)(44832011)(5660300002)(31696002)(8676002)(6666004)(2616005)(956004)(4326008)(8936002)(26005)(53546011)(38100700002)(6486002)(186003)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U2tLbWxidXVJRVB3NVh6dlROOWkxMHJzYWN1R2duVjZoSlNSaDV0WEpCekhh?=
 =?utf-8?B?bExoSG51QVkyNFgwcVVoSW1hcFRybGswaWp1OWlFeVFUTFB5NFR5aFlKRFJh?=
 =?utf-8?B?QmVhbktGMzBHazdUZThBaFhPMWRzajErdUl5eEtHNDEyZXR5SHU3eU9OK3J2?=
 =?utf-8?B?U3NRUk85S3lrNmZuZU1lWDA1Q0Nic29sWnl6bFFaUXFVQ2tQMEpJa1g5WGlQ?=
 =?utf-8?B?b2xKV3VQVHFqVXlRbDdDdGN3SHg2TjB2L3A4dWZXUmlhZ0Jua1dUQnVEd2Y5?=
 =?utf-8?B?MkNxTllLYWlKdmRpY3ord0RqdFJjKysxcnFXZW9nbjhQT2NkVTNTUjQ3RXk2?=
 =?utf-8?B?UzFmYURHdXZVelBocTFRMFMxRU9CcnpJWGkrOURycXFhQXRoNi9uWXl0Skdw?=
 =?utf-8?B?U0xnK2ZRUmZnQjA4YU93WWVXcUI0QnNCRHpuV3hQVktBTC9XK29IQnBOVkh3?=
 =?utf-8?B?VXBhakVtYzhza3dTK3ZFNFR6S1hZcTk1YU5leWtTaTRFRWNVc3V2V0QwRzhW?=
 =?utf-8?B?OFY2RVdPWUN4ZlJLRlBUdUJXVzVhM0hiWjRVZmx4M0VhSlk2b3ZYazF4UkNK?=
 =?utf-8?B?V0pMakprWlF6Rk5kUUVva05zdWZUclhVYVorWnE5cFRLOFBuUTE4ODYrdXBR?=
 =?utf-8?B?Q29hZHBtRnZyRWZ3STBzTFB2QTNLS09hSWxzU2xUeEZ2U2tKeFNoNGdoZUdv?=
 =?utf-8?B?VUFIYTg1QTRWNCtkbEZVcUMxSWQ0MWlwQitzNVJSMm1OZk9LWlNqNCsrU3RN?=
 =?utf-8?B?VURqY2t2eE56bmplekxxVjZiQm96MmpyVnBpL3lkd3VxMHloY2F0bHhzNW1k?=
 =?utf-8?B?bDBkWW0venJKVzlTZXFxSEFQaVZLampjeFF3VU8zYitua3V2bzdKNWdjMWxo?=
 =?utf-8?B?MUp3ekwxVHhqdWkwYkNPNzRxdEMxdnNMcmg1YTNEdVJkeWpwc3RyZDdVb1JC?=
 =?utf-8?B?TUxJNzF4RVVtdjduK3hPbHdzaVUrdWRJWThpRHNJVlhwVFg5SHdZbGo3RER6?=
 =?utf-8?B?R0hkNEkzaXFWZXp4M0djUVBUZjdXMDhISTQzZmtUUmVpTXBMWFIwRHJqYm1w?=
 =?utf-8?B?ZjlQRGZrQk4vbTZrZ1k3c3BRNUprM1FMNm5hRnZ2a20yTzYwRk4vSmM4UHZN?=
 =?utf-8?B?ZlFYbGg5TG1EMldJVVpMNFM2TGdLSmhBVGxOU0RkT1RXdkRWb2xxQXlFOGhG?=
 =?utf-8?B?Rm4vMVRVMGJxZHBsWHd3OTBldzlsVWlWL3JjeUpqby9pMkxZSDRnZ0JneElm?=
 =?utf-8?B?ZXF2TDVZejZmVHA0YXRTcjNBdWZVRUMrc2tBaE4zTTg2ckNaeGdoZHkvY3ly?=
 =?utf-8?B?aUVYMm01TWp1UW1GaXlObytWQXdyNVpFUnZZbmFRNEk3STYzYnkrajM2T2Nl?=
 =?utf-8?B?ZHpENGErQ1ZMbWNHQXpOSncveUtZRS9GeUtmNW8vUHdYRWxwcmhBNzZvOVp4?=
 =?utf-8?B?dGxiazZGYWR4MjBMN2VMQlVEWHFueXlKWkdTTGZ5SmRHZTFhd3FzWk42VU1h?=
 =?utf-8?B?UmZMNnZIZG5KUnAvaUduQ3NHdHhQQ1Q2WWwrT3c1SVlJRC9xK2Q3WU44eXQr?=
 =?utf-8?B?VHFUejJ3Lzc3YS8vcnNxdXF5Z0ljVWord1J0TVFURXJ6VVJmVUQ4bXRsVWxp?=
 =?utf-8?B?em9oWXo3dm8vc3F5ZzVmQ1R4TmJCUlhpN3ZmbFAzR1krUjFGczIySm1ONG1J?=
 =?utf-8?B?RWQ1Mlk2dnF4dXZwVENsbU9vRVcxdUpJY05PS0J1N0k4OGRrUmpDR2wwRjdL?=
 =?utf-8?Q?NHvWMUGA6RhD8JYiDDf9WVAvDCJn4axrT9c6Dp7?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1895f9fe-5d9a-4df1-281a-08d98416d15e
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5399.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2021 13:32:58.8034 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2PlvfeMG9akSXJsFVKpdKwLyl90VZOzlLE5V+hQqyAratqhWUxtYk+SK+Ig6Ik0w
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5400
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

The series are:

Reviewed-by: Leo Liu <leo.lilu@amd.com>

On 2021-09-29 3:57 p.m., James Zhu wrote:
> Move jpeg2 shared macro to header file
>
> Signed-off-by: James Zhu <James.Zhu@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c | 20 --------------------
>   drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.h | 20 ++++++++++++++++++++
>   2 files changed, 20 insertions(+), 20 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
> index 85967a5..299de1d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
> @@ -32,26 +32,6 @@
>   #include "vcn/vcn_2_0_0_sh_mask.h"
>   #include "ivsrcid/vcn/irqsrcs_vcn_2_0.h"
>   
> -#define mmUVD_JRBC_EXTERNAL_REG_INTERNAL_OFFSET				0x1bfff
> -#define mmUVD_JPEG_GPCOM_CMD_INTERNAL_OFFSET				0x4029
> -#define mmUVD_JPEG_GPCOM_DATA0_INTERNAL_OFFSET				0x402a
> -#define mmUVD_JPEG_GPCOM_DATA1_INTERNAL_OFFSET				0x402b
> -#define mmUVD_LMI_JRBC_RB_MEM_WR_64BIT_BAR_LOW_INTERNAL_OFFSET		0x40ea
> -#define mmUVD_LMI_JRBC_RB_MEM_WR_64BIT_BAR_HIGH_INTERNAL_OFFSET		0x40eb
> -#define mmUVD_LMI_JRBC_IB_VMID_INTERNAL_OFFSET				0x40cf
> -#define mmUVD_LMI_JPEG_VMID_INTERNAL_OFFSET				0x40d1
> -#define mmUVD_LMI_JRBC_IB_64BIT_BAR_LOW_INTERNAL_OFFSET			0x40e8
> -#define mmUVD_LMI_JRBC_IB_64BIT_BAR_HIGH_INTERNAL_OFFSET		0x40e9
> -#define mmUVD_JRBC_IB_SIZE_INTERNAL_OFFSET				0x4082
> -#define mmUVD_LMI_JRBC_RB_MEM_RD_64BIT_BAR_LOW_INTERNAL_OFFSET		0x40ec
> -#define mmUVD_LMI_JRBC_RB_MEM_RD_64BIT_BAR_HIGH_INTERNAL_OFFSET		0x40ed
> -#define mmUVD_JRBC_RB_COND_RD_TIMER_INTERNAL_OFFSET			0x4085
> -#define mmUVD_JRBC_RB_REF_DATA_INTERNAL_OFFSET				0x4084
> -#define mmUVD_JRBC_STATUS_INTERNAL_OFFSET				0x4089
> -#define mmUVD_JPEG_PITCH_INTERNAL_OFFSET				0x401f
> -
> -#define JRBC_DEC_EXTERNAL_REG_WRITE_ADDR				0x18000
> -
>   static void jpeg_v2_0_set_dec_ring_funcs(struct amdgpu_device *adev);
>   static void jpeg_v2_0_set_irq_funcs(struct amdgpu_device *adev);
>   static int jpeg_v2_0_set_powergating_state(void *handle,
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.h b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.h
> index 15a344e..1a03baa 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.h
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.h
> @@ -24,6 +24,26 @@
>   #ifndef __JPEG_V2_0_H__
>   #define __JPEG_V2_0_H__
>   
> +#define mmUVD_JRBC_EXTERNAL_REG_INTERNAL_OFFSET				0x1bfff
> +#define mmUVD_JPEG_GPCOM_CMD_INTERNAL_OFFSET				0x4029
> +#define mmUVD_JPEG_GPCOM_DATA0_INTERNAL_OFFSET				0x402a
> +#define mmUVD_JPEG_GPCOM_DATA1_INTERNAL_OFFSET				0x402b
> +#define mmUVD_LMI_JRBC_RB_MEM_WR_64BIT_BAR_LOW_INTERNAL_OFFSET		0x40ea
> +#define mmUVD_LMI_JRBC_RB_MEM_WR_64BIT_BAR_HIGH_INTERNAL_OFFSET		0x40eb
> +#define mmUVD_LMI_JRBC_IB_VMID_INTERNAL_OFFSET				0x40cf
> +#define mmUVD_LMI_JPEG_VMID_INTERNAL_OFFSET				0x40d1
> +#define mmUVD_LMI_JRBC_IB_64BIT_BAR_LOW_INTERNAL_OFFSET			0x40e8
> +#define mmUVD_LMI_JRBC_IB_64BIT_BAR_HIGH_INTERNAL_OFFSET		0x40e9
> +#define mmUVD_JRBC_IB_SIZE_INTERNAL_OFFSET				0x4082
> +#define mmUVD_LMI_JRBC_RB_MEM_RD_64BIT_BAR_LOW_INTERNAL_OFFSET		0x40ec
> +#define mmUVD_LMI_JRBC_RB_MEM_RD_64BIT_BAR_HIGH_INTERNAL_OFFSET		0x40ed
> +#define mmUVD_JRBC_RB_COND_RD_TIMER_INTERNAL_OFFSET			0x4085
> +#define mmUVD_JRBC_RB_REF_DATA_INTERNAL_OFFSET				0x4084
> +#define mmUVD_JRBC_STATUS_INTERNAL_OFFSET				0x4089
> +#define mmUVD_JPEG_PITCH_INTERNAL_OFFSET				0x401f
> +
> +#define JRBC_DEC_EXTERNAL_REG_WRITE_ADDR				0x18000
> +
>   void jpeg_v2_0_dec_ring_insert_start(struct amdgpu_ring *ring);
>   void jpeg_v2_0_dec_ring_insert_end(struct amdgpu_ring *ring);
>   void jpeg_v2_0_dec_ring_emit_fence(struct amdgpu_ring *ring, u64 addr, u64 seq,
