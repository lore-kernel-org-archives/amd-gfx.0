Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 799FDC4332F
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Nov 2022 15:50:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0384610E640;
	Thu, 17 Nov 2022 15:50:21 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2076.outbound.protection.outlook.com [40.107.93.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 19C6610E63F
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Nov 2022 15:50:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CFtTnVWjuT2beyvaFxY7y2EkxxDyvVI51ury24XnfH7+VXXk362UZayBQjgeXy04KOVJPGPh/RXa867Pb9uAm/uS4E9zJQRzqPZkSjMEXRZyw3SMYKFDN6gZF579g92YvVMJJPv8jxtOkYE+SudNvNqrTup1/7Z/MZVY1KjohjsQM19jIcdScaXdGUKRGgpEm6NQ2P6URl23wSQ3AFlLjfEGopKYxm3fYnYtylfKW4UG5dJvQrltPDL582gsSeaxtmh7FClg9yqTYPrJMmp10Ijqw7XNjhNpFtnTsI2MvDe8BeKEC0TeemoFHHJFlywcqk3ulys25kL0kq3twmNJyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oPONtV5Cn5wh8gyERrB85MHR0+9+g++KXcLar/7axGQ=;
 b=BJGxYMFTtMj6A0akN8m5Dlrz+1ScB9A5FhNoT7Y1TwB+3Gb2jFAiIJaFssBkJV7/Usvf6Hnm86CUAgFUXIFnS/QKY1H1AuFxXkvZuad7CPLikkix5WLU8uh/u4IB6dq3Nahz/+weiDkOYhZEW7AnFM8OyQl7aFNTKxm0CtQEXChzZ4Qm7USGVH1mdAPvZuefA5fZYhO1bhXJFE05j313E/dTIClMOPYqSxMDURSyFcGauYEI+s4zqMEAFKGnThfHrAWy8+wfQ76ljQ1GJuIA+oneUDPbsZotGI709VLvr2+ubC5yZBlMP3ekAVnWJsLTwl7o3n8v4hC1ZTXGAbYYZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oPONtV5Cn5wh8gyERrB85MHR0+9+g++KXcLar/7axGQ=;
 b=2nLxl4hC8rjDSZUBVvLDy6ab38MvrpXeF94FVqzeu0jZCLWJDk4YT/amNluvkZuLcGGSiBL1yMtgsfpFhY5uIpNj1muucIGxFcAbi8/nAFNI0dpPM5cwvTtVZImcniQAY8YvXRDdl32JXmlmSepzmdCSpN6SVtk3Vwgw9vVBsls=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by PH7PR12MB5733.namprd12.prod.outlook.com (2603:10b6:510:1e0::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17; Thu, 17 Nov
 2022 15:50:16 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::5d8:f3f2:d940:5350]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::5d8:f3f2:d940:5350%3]) with mapi id 15.20.5813.018; Thu, 17 Nov 2022
 15:50:16 +0000
Message-ID: <23066e5b-3df2-6254-060d-917e3eeccd05@amd.com>
Date: Thu, 17 Nov 2022 10:50:12 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] drm/amdkfd: enable cooperative launch for gfx10.3
Content-Language: en-US
To: Jonathan Kim <jonathan.kim@amd.com>, amd-gfx@lists.freedesktop.org
References: <20221012190746.3318031-1-jonathan.kim@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20221012190746.3318031-1-jonathan.kim@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0286.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:6d::15) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|PH7PR12MB5733:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f1c3962-2eea-4357-1492-08dac8b36b3e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IKc17Mqv3tENBrc70R/yjwbMsq/nljyEIJ5Ww4rh5SjdSF7W3cddqy6xK3uQjo2nerb1z9lSwQq0HH6GZoWzFDg5wA7YSiKqkdxas1eaMouARzi7+TBPSr8SpZgZU9XYAIn3bsRenjGTUcqv5IDh52IuecVw0woEZSzAjoPt1erkBnASQxfHopYNE3VlxH/wMMqBgl3OSSf93MMco0zTthWO9F63aCLEAuDpzsB1pK1l05ZpdcmOfIdbOGOeAZcUakptLoDGJUEpHkJ/gY20V11vLeln+h7qe/2i+5KPpwFL6OTCt66/HuMUhs0ZZUCvdbUNlZKyuscxE1r6jCXz9+LkIg6Z+AYWuZR3O2qF2ya4mVj+Zl6P6d3B+b4fsl3blIGGT7q15VS7eFl256ZUWl2P0b8DTSp73kmCTjOG9UeHsDn80s0h/39pMpCbdxbrZPhbTJmqfZhZ5oim06TtjXO7swnLpUBiCg1pmD2ENIMIVE84mZ7/oP44EWiQtURHKJH8xC1dG1tG40yNVffveV7JHuB5W+mcpXltgNj13+bv3NU1hxdHyix6g2P4YlvlFJHI7beXEkGbNVZ322oooY9+4zK7aHTHG5yDL7LpIbYuJLlEvauuqpp2yw1loa13eqVMcYZRu/00rNshcugz0QRHbpFixpnAqZoPAvliXmh7F7CF3PxiX0cA4Lyk/orKF3Yq995In1oUHbQLLjEJyyfNQQrdsD7iAdKPdfNXrGY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(376002)(346002)(39860400002)(366004)(396003)(451199015)(38100700002)(6666004)(83380400001)(31696002)(66946007)(66556008)(8676002)(5660300002)(86362001)(66476007)(8936002)(2906002)(316002)(41300700001)(6486002)(44832011)(4001150100001)(2616005)(478600001)(186003)(6512007)(6506007)(26005)(31686004)(36756003)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U3FpcTkydUhRNHNVR1JYMWhCWUIyYXdzQ1BVNzV6a29OZGN3aFM1UHNmWHd1?=
 =?utf-8?B?TGRUYmkyYTVDQmlET2tIVHZuL1phRi9lSnNSejIrWXFaOHdBL3daRS9PN09N?=
 =?utf-8?B?ZVBvMEw5Ry90ZE9HcWkwMDBvNHFPSDlyK1RRRTI5eFBVc3M5Q1F3WHNaTW1W?=
 =?utf-8?B?RHAyaDcwckt2NDlWWDB0WGRCWCtrYzdOZFdQdjNkZEVlbHJLRU5XUVRGNFRa?=
 =?utf-8?B?YkplTHZEbUFRcHAySTZLWExlUkpaOFIxQjNwVndaeXVRTk8xVmZ4ZGRHOE1i?=
 =?utf-8?B?SmExTWRmNnZXcjgvQjBsUzR2ODk0VnpFVVBpTnF6cTE3UEQ0dTZOL29QSzg2?=
 =?utf-8?B?L3IxWVVqY0FOencwMlpNeFNvengyYkhDc2RKY1AwWUxDclJ1UFN5Wlo1ZXhM?=
 =?utf-8?B?QW11dFFMRFlFMXJpdnhiaEVDZmh1TEdBS1UvTkFTcTRnbXFJRDNHbVU3K2Fr?=
 =?utf-8?B?MFRGdDJSNUhRSHNQelo4aThTMGQ4MW12aEpSUitCUml5T1ROSDN6a2VIVU5p?=
 =?utf-8?B?WW96dC80a1IzQkdNNlB0cjJTTElSODRQbHJJSk9YSnB0Wi9FMkM5TnRsdmo2?=
 =?utf-8?B?MFRoR1dRVldtV0x5OHBuSlpDMGYwOHRab0J6OE5PVTh1RnFHeTl2S01NYTk2?=
 =?utf-8?B?SmhuTWlncVpQL3l2bjNSU2ZjSzd1ZGxVNlFQZDJ3VXhPdjlkNCtnMlNBclAr?=
 =?utf-8?B?Vm5ha2lTWGhBaFZjcWFUOTBXcTlLbndQQkRuZmttZGZWUkRxeVdreGs0MjRm?=
 =?utf-8?B?eGdzdUwwOExRUTJra2p2QllOTjdQSGp0TFYwREorWUtlSmJZTXVldGxTVDln?=
 =?utf-8?B?ZGRJMHc2aDh3SC9GSmJsbGtOVDZ4eHlDQWJoa08wUUQ4S2g1YXh5V1NkbXEx?=
 =?utf-8?B?b1NPUWJpS29JSTRVdWRHcjM2SjVMcnRONHhmTVdFY05YSzJ4MkhBMWUzaVc2?=
 =?utf-8?B?T0V1SVNneTdjQjczZ3p6S1pQODUvUC8vYmsxaHNKRVRsSVErRnpYcy9XWFRL?=
 =?utf-8?B?M081S0gwdWNuVmR1SVIvZERuUmZhL2lIWU9kR0FJTmtiM3BzODlmS25JbU5m?=
 =?utf-8?B?enFmNHNGNzhTTnhyWXNGRW5DcHY2S3JPT1RuWnZwYnlvREJScEJJa295dzZQ?=
 =?utf-8?B?OHlkUnNxM2hTT08zMmdQbFZCV3gra1YyUXovVTBUWlhabG1pU05STEdHZ1lk?=
 =?utf-8?B?QmJSZUFBcEtWRU8zaEdET25kSzhXdnFpRWtzUjNiTGFQNlZrb3lNS2NQb3Jo?=
 =?utf-8?B?Vm54eHVQeG1CNm8yRGlqWi83L3g5elJrYnUrbFIyQkdSSWR5eVF1ZFhuSk81?=
 =?utf-8?B?WmxyVnJvOGtSUkxpMVQ2emVJMWU0aElSOFlrcllxcmc5Z3VPbUJHT0c0SUMz?=
 =?utf-8?B?MFlVeEx3S0YwWWQrSEJTOUtSaW5waU9mekVJN2pNbmdKaC9YMVpObXVhcDBs?=
 =?utf-8?B?cVJNZWduNmY1QldYdHZ0Nmhxc1ZvZm1adWhoQXFkajdXWFJTQnhKR21mTnJq?=
 =?utf-8?B?VnNrVWRiQVNVV2RSSExoNzNtRmFjZnVtS2RiMmVVVERFUThmNUROMzZ1TVQ3?=
 =?utf-8?B?UXN3R0R6ajlRZ3E5VVllbGZqdmtHMHV4dXR2ck9QMGFZMVB0MUhBL2ZId1E0?=
 =?utf-8?B?MXhSWWtPb3N5dDdQMEt6dUpCdGFtMkZFUjMxblVCdzYxbDlwc0I2T1owTFZG?=
 =?utf-8?B?alZYQnhac2REYVNXNkFvZWRiZHVIbmhvcE93SFd2dytNNmZPekE1RUo5Qlhx?=
 =?utf-8?B?aE1YbEdpWGxtK3VDQ0xVUzNISWM2ZDY1ME1wTEczdG5SaUZab2dDRVZXY3Bs?=
 =?utf-8?B?OXN1cVBMOFpWSSsrNnVHdi9jNXMrWVFPR1J0Mk9COXJWUzRaUDkzclFWaWNt?=
 =?utf-8?B?TFRocU45ZjZCZmNRN2dUMVRFdjlsazVyYUJpSFRpOU5hNDA2YlkzRzdMaVdV?=
 =?utf-8?B?VHZNZzl4YVVRL0JJTXZKcEZ5TERYdm1TY0lPZG43eGM0TGlMTy8xWnlIZkhZ?=
 =?utf-8?B?cGFjNm1xblFOQ0lpYjFFd2kwbWFTQVRZYXBYQTRHSVU3NGg0N0xsNWkwMkVX?=
 =?utf-8?B?RVR0anFyWEt0SjhyNkUyUWNiQ3dCSDZGQnJiSUF1b3F0NFdFdnlDN3ZvUGEv?=
 =?utf-8?Q?Zs66GKcs5trHQx1q6mbG/fi1B?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f1c3962-2eea-4357-1492-08dac8b36b3e
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2022 15:50:16.6225 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zZ/UsSwEbLUB752SbB+mIFeB28AP3G7yKqTkHR7S5pZwO5I6NMmcPW1IoI6HQrC48CKp2hCr89y9iz+YbuJnRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5733
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

Am 2022-10-12 um 15:07 schrieb Jonathan Kim:
> FW fix available to enable cooperative launch for GFX10.3.
>
> Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_device.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> index be7a0b5a2dbc..66296cccbadd 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> @@ -498,7 +498,10 @@ static int kfd_gws_init(struct kfd_dev *kfd)
>   		(KFD_GC_VERSION(kfd) == IP_VERSION(9, 4, 1)
>   			&& kfd->mec2_fw_version >= 0x30)   ||
>   		(KFD_GC_VERSION(kfd) == IP_VERSION(9, 4, 2)
> -			&& kfd->mec2_fw_version >= 0x28))))
> +			&& kfd->mec2_fw_version >= 0x28) ||
> +		(KFD_GC_VERSION(kfd) >= IP_VERSION(10, 3, 0)
> +			&& KFD_GC_VERSION(kfd) < IP_VERSION(11, 0, 0)
> +			&& kfd->mec2_fw_version >= 0x6b))))
>   		ret = amdgpu_amdkfd_alloc_gws(kfd->adev,
>   				kfd->adev->gds.gws_size, &kfd->gws);
>   
