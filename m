Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D8EFC00140
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Aug 2022 18:57:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 954AC10EE2D;
	Thu, 18 Aug 2022 18:56:32 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2058.outbound.protection.outlook.com [40.107.96.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 093B010E504
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Aug 2022 18:56:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PqcSESOpIsobMeE6//7V+/QZ+nDvGD2u7bq606vCdL/oydYzhv2DOBwSyPRgyV1BnWnMmgv1fZ9AlSHX2bKk/wxhQTSvbREMhq3K1RUClk6PCStW9AApo3udNdfyJ7YstPfyIVj34K8K6cdKpJ1jrBsl72xmd2DbxmE3IwPO1c7X/jVVnBU24jisQaVG9TW3c4JfHQFhaVExjIrbGuEVYAyTGrLxj5iOJiIIMmi8kQFQFKYGaNqaH1bhwUtwCrtvkt2DLsieIajErfmZtDfvypYoiTYyuwJiJk9MKvbQJfJA3c7sB0Vle4G0AT8QYPrbrECxSLvSJQ1sIx9twfKSnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jx+12ewUQj9/hlOia6iwc5W1HPxTJHkPyZndKA/tcmA=;
 b=WhTM5fLKjMFXyJAcYwVnJi10y6cIVEyqHe9visbSSTGaPdc7NiA6LiU1CQhcKiePbv0lvoyPm9hOVID2qEoPmOSR/F5jRSGVBQBaNitWqUePSZezguqXKZsf9BVEEA8AYunj4AnG3/HJjsb9+5bEXJgt5v6xNcRa4E4hj9xLIp1Nu/b1wej99ox7fecKF/9CAZI0aAWCzSOFQLRGY8clTbnzu+sClO8IhbyEtqQiDxHALIqMtB6W7gX0WCq4StCQQH/jCXzkWxvrpIoM3QHWnrGfnQLHEKwk1IJ/8IyIXaTuW4/qp6wXZaAxybvZ8J4YzbNG9tbiy/hFpNjeImFngQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jx+12ewUQj9/hlOia6iwc5W1HPxTJHkPyZndKA/tcmA=;
 b=MiQEQj6p3GmUTyf/ELgACdfiZmrYI2+7zXdUY/868HRC1ADev8x1lStfDBIfG5iGIWHbhkUQ2AVEv4vXh2QYRc3FlJBHi1mIEoLp21cRd4KVKGV1Kr7TlEQS7vQxYcDfTYdXXOgcCgsjpKWsjcjU0k94ltdWioMkjESY/fiA1k8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by SJ0PR12MB6968.namprd12.prod.outlook.com (2603:10b6:a03:47b::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.17; Thu, 18 Aug
 2022 18:56:15 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::406d:afb5:d2d7:8115]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::406d:afb5:d2d7:8115%5]) with mapi id 15.20.5525.019; Thu, 18 Aug 2022
 18:56:15 +0000
Message-ID: <3342881c-c626-7a43-5488-ba83c0152280@amd.com>
Date: Thu, 18 Aug 2022 14:56:13 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] drm/amdgpu: Remove the additional kfd pre reset call for
 sriov
Content-Language: en-US
To: shaoyunl <shaoyun.liu@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220818181955.11762-1-shaoyun.liu@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20220818181955.11762-1-shaoyun.liu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0148.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:e::21) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0b6d2195-9730-4e12-5dda-08da814b53c8
X-MS-TrafficTypeDiagnostic: SJ0PR12MB6968:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Apj0Qs/Z+dpRX/5Ia9ty5sb9fSzdagp7jotam1qQRGjDtZbpcsieddsqAgZ/UKyPmMrX1tA+coEUOeztIqjLzaT9EU0Osf9a7r8UowlUdLa6vqfqcM/oiB2SCw+2fYuh9q+msd14y5IJQRSyLfpy4NkUfA6ZnjzF22w0tOw0U/HFMlM1H8pbtt6oUyjC0M4I7VcQP7+QjyodAzMbEhnjEHLhjr054zY46wZjshqc3c1iRdMAhstV/1nltIlGvUGpYOpcbneQGVP7manqX+sqEdaWq9d7YTcUxMm+6HaEy5Ow6zpG+apwl943hoK/grU8owwAu7MMJtx9oJFmfunl983QgrbYrLE/eaxD1K4c06aat42bP6zL2uXqslGDwosiL3peTMcb9NkscERKCDKJyfCmAH8HTAnyQq4Kbx4uIlgVFOSe+RRR8a4Eo2QfGaq/d0+nEdBR9NNoDPQsDZ02epZtdVv/IsD43CG6gT8Pxi79TCg/QmjfKNuafa0/9Fzv/316dGZBoKQVMkqP6LjIFJbqHKBUsmOLX6sQHYFTWABSHz0XmKqZS2yOV5hGLOeS38GuKvGZOlvLDtmXRzMQ8KoKYz5m54AP2LorSDem4YsZsmjv+KXG85OnwrrPc1AvceXYJ6nZAIzdKJUnMtZZGPyFdyGumrDmJOpI3ODXqV3AQo00yASEJlu8UEmJrQzWtsU0k6e7Z55rd/eMh7/u0NCq8/TuvCIFpVr2VQYEp2B1fnz6JkJJ1BZj0+mmhtnc0zjCa9i/lSpsi/79Ve3ndcQVqjYA8sIiy0tpDq8r/Lc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(396003)(366004)(346002)(136003)(376002)(39860400002)(66946007)(6486002)(41300700001)(478600001)(66556008)(316002)(31696002)(2906002)(6506007)(38100700002)(86362001)(8676002)(66476007)(186003)(26005)(6512007)(5660300002)(31686004)(83380400001)(44832011)(36756003)(4744005)(8936002)(2616005)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RHFPc1BncHoxanJhQTJhcW9DQW9rUUZnZVo1c2NHQWtHb3R3Rm9ieDBjMGY3?=
 =?utf-8?B?UFQwbGQ2SStKNDQvUHExQ1dTdkxWeDNvUDZKQUZYRUpSb3I1aW4wcW1LWmJC?=
 =?utf-8?B?VVU3ZTZDVjVIcXlZM0J1YVBpWEpaY1Q5cjFaSWsrSUQvUUYwdENockRCSnVY?=
 =?utf-8?B?VVA2anBSRFlSalZETGN4RldwMjJZYk5KUWJ0eWNkeDNIUHNoN3pMWEFnS3B0?=
 =?utf-8?B?eFJiTzhseXVRak5ocDBlVkhoMlRGU3ppU2dHY2NHRlVFWloycXFxR2VwMEha?=
 =?utf-8?B?REkwbVNkTXpmc1IrYTVzU1gyc253WTIrTVgvOGsxc1ptbms1Yk00eTVCTEJT?=
 =?utf-8?B?L1U3ZHRVZi96dUROUGlIajR1aUF3SW9GdXNBb3pWUmFsUTUrdk52dVhSYmlW?=
 =?utf-8?B?ZWE2Qld4blo4SzFaeWZpRzlPUlZQb2RtSzY1bVRyYkV4NXVGTC9wcCs1bWdY?=
 =?utf-8?B?SlNXc1lDMjlaaDRZODd1QjFBMjFFNy9Pc3R0MWMzc09XTHB5eWZtUi9IZDBI?=
 =?utf-8?B?VGt5UVhlZU0veGhvc0RXUDI1RCtPaTJaY09uTzlJNWxLV3dFc3dmckVBVHFm?=
 =?utf-8?B?bnBZbzd2ME1LbU9ja0lrZTN1alZ0N2Y4dlNJMDU4eFp1MG1qVnZ6TTRNRlBU?=
 =?utf-8?B?QW8xUFFPZk9xT2E5bzhuYVZGcDBNUHdGNUVEc3cycnF6U0JHTGRzQVVtN1pM?=
 =?utf-8?B?endTeDAxTnNUSUtLL2dCRXRzaExSWXA0QXlSMnRxS0M4bFVLQURncFFnd21E?=
 =?utf-8?B?NGNMN25yRkZqOUVzYTN4WTlwNkdGOWptTGlaejFIWHk0UklMMFF4TDUyUytL?=
 =?utf-8?B?UzBLUnFGcDZhTFFkTWs4Ui9OcXdPMWdyV09ETEtCWk80dGNMZWN5RWUyOEtG?=
 =?utf-8?B?NDJydmV6S3FWN0xIdTZYb013MG9xSHRzalhEQi80ZlBnSUlMbVNjS3lRNVZP?=
 =?utf-8?B?bXByZ2Y0TXhVYjgyUWJ0LysyUWUvWTJUclR5dko3clh6V2JTeDd1RGdkK3Fq?=
 =?utf-8?B?dURJSDl6WTZBZTFQbzdWRDY3VGw5UFBxYmRmUjZreHR3Y2RTZEE3S0ZkTldO?=
 =?utf-8?B?UmFTVU14aVV5M2xHTDNBQzI3SXZEZ1d4OFhKNU9YRm1Cb0lQRmxoRnNIMWQw?=
 =?utf-8?B?OURzRnRKUW1uY1dQenlMSjluVDZLSlQyenFEWGluUWxYMG5hYVN5SmFnaSs5?=
 =?utf-8?B?RVdPcVE3ZUs3dzcvQjFxM0hiNzEyTWJMYk5Id3JNeTlmSDRrWU5aK3ZDRmlX?=
 =?utf-8?B?VDY4S2t5NnFaZlRpaWZNOVdKSHJGRG9DbTZoaCtwRmJ2S1AvbWptdFo0cWpq?=
 =?utf-8?B?SllrWUQ1aE9RUUJyM3VZc1pxRHpHVmdyVTkrdTZhVVBUTUg4cVYxSjM0d2Zj?=
 =?utf-8?B?UXJpSFovcHEra05zanZnendvU3Z6azlocU5LejhoL0pYQ3lLTzRPeituMm5i?=
 =?utf-8?B?eTVLTW5XdGJsZElMNFdLRlBJSnJsMkVWcTdDeFB4Vi9sK1RQcGZwM3FjTXdN?=
 =?utf-8?B?QUNiVm1nTUQwVXdzVWlKWHJEcWVFcktTbHNZUjVCT0duTUVoZWxkbHpWS0ty?=
 =?utf-8?B?QS8wTjVhRW1nc1lsb2cycGEyU1NMN0hpTm1HM1lqSDFWQmNWV05XMmJ1end6?=
 =?utf-8?B?b3hYZWtHOUU1NzAwMExtaVZrRzhRdW91OU9PY2RuYXQramFsb1o3VXJQSkhC?=
 =?utf-8?B?eGNvREQzL0NaZVNISUFPM2RDcmVnUmZGUzBic2xOZGl4UVVVcEhmUFQ2eDBG?=
 =?utf-8?B?cmZVSjRGaDlMU0JzRDl3WlM2bEw0L00rN1NWRDlxZ283TVZYYzRNVzhaMG5N?=
 =?utf-8?B?TW9idDh6bThmd29pQUFGQmdXd0VVTVF5cFJqU0ZXcFkxaWFtZm5LK2NEVkt2?=
 =?utf-8?B?VTRBZ2JYZEQrMTRESCt6Nm5kNkxBa3FOWGZkaGRKYjBuWjRkbjM5OVFBZk1W?=
 =?utf-8?B?YlFubysxTnhid2ZPVlNhMDk2Ym5ZSmthNVI1bVdUZlo5MXRhL0RhVDdUNnNx?=
 =?utf-8?B?WjlBSjZUd09ZSTF1YkN2QlNkODUvNDhuNGlZRDBGc0d2RW1OdzFvcmM0ekU0?=
 =?utf-8?B?bUhhRkxZUEhFdmtLekRza0ZMY0ZpbWVweCt0aUgwSmVKUzBLMkN3eXlNTGNu?=
 =?utf-8?Q?XhBMgCh9U/xhqphZ66MdRQuFD?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b6d2195-9730-4e12-5dda-08da814b53c8
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2022 18:56:15.5766 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TQnaTb9SgJmNhyBeNetsjjte+54irq9HvrGgD+IpXZRXykmggrEDd3m9mRY1pjnaurhKOclYviZZcV5OowiUnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6968
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


Am 2022-08-18 um 14:19 schrieb shaoyunl:
> The additional call is caused by merge conflict
>
> Signed-off-by: shaoyunl <shaoyun.liu@amd.com>

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 2 --
>   1 file changed, 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 4cd87dbb108c..d7eb23b8d692 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -4417,8 +4417,6 @@ static int amdgpu_device_reset_sriov(struct amdgpu_device *adev,
>   retry:
>   	amdgpu_amdkfd_pre_reset(adev);
>   
> -	amdgpu_amdkfd_pre_reset(adev);
> -
>   	if (from_hypervisor)
>   		r = amdgpu_virt_request_full_gpu(adev, true);
>   	else
