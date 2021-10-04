Return-Path: <SRS0=otPk=OY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D229C433EF
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Oct 2021 10:27:56 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3575D613A1
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Oct 2021 10:27:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3575D613A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DB85F6E9B1;
	Mon,  4 Oct 2021 10:27:55 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2040.outbound.protection.outlook.com [40.107.223.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 58B236E9AD
 for <amd-gfx@lists.freedesktop.org>; Mon,  4 Oct 2021 10:27:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=it6j9DYCjpyBqaIktDdLwzCY91n37X0OAGkvj0l1C6W7nMK2mKyar3dp4PwF5ibKYqeiX0XwPG/U5kL1GNtz3AF0I/N8zV1S2KJET6mrsIRN62mOK3G/tIWS1SSaPgrcigluftwJmvGI9LOB791yb9e4SuYgfKy9KU+PWLBCI1tnWlGRKLM5vmOQS1sw3ve0Qyd7ufYCG3MUJ1Nwt2lc9dn+Ed4pG9VEGZ7dF5JhVz//KTg9d7/8HfaKW7rPkxTbr1GDcdsyw6kJzuizE3H7YNe5W6xAaDHxovV1nTWP5PDZozy5qGxY4AsfLZTkcMfPyrvpbH2kpDjovjlhnIdFtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iHvBp7MJWY3g1Pxh0YetfQk+23zVfVUBt09FRIa5EpQ=;
 b=hGgK0k8tNED9zx27u/yNEhNQreRetiok/Oh6OsprRM21dL5LaZk2MW/GiFp5ETTTu9xhPe1gn6VEYrihOqA6cZrNWYwyjUtoPJW2YtdPEMvF8c4RedIIdrGwRxgG7bHl6DUzKp/6Z4dE5kHIR55J7K05KSYKUI1p5LTEGJH2t4fEeoHPw83Z04j2YC83ksTBsMk0uM7fe4GVKW5pYM7uccqhW2R7agFekwLydEtCrKPy+akefImXyhkNFvTdlPaRinF1UXUMEAE4TDlNsnqFYrbv19ym16ukMH/MLPzk2+I2URwc++v447cxBwGjtdTKc98fGscTrgqUNrKvTkk+6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iHvBp7MJWY3g1Pxh0YetfQk+23zVfVUBt09FRIa5EpQ=;
 b=ksJQTrEb50kG1EbrRzADRjtdHwKm38zg5tuOixF8zMP6ihdwc6ii5ZH8l2yDNGPPHm18fhtMLpNR5be+Tka7soz1Ds8XIHpClQf9JPxPqmO6OfnU0EFZ8guwbbwSzSW97isQG0ipTYlv2nLdt4zJxLjzvid3y9cqu306poXYjBg=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3930.namprd12.prod.outlook.com (2603:10b6:5:1c9::19)
 by DM6PR12MB3932.namprd12.prod.outlook.com (2603:10b6:5:1c1::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.15; Mon, 4 Oct
 2021 10:27:52 +0000
Received: from DM6PR12MB3930.namprd12.prod.outlook.com
 ([fe80::591a:8986:aca2:c560]) by DM6PR12MB3930.namprd12.prod.outlook.com
 ([fe80::591a:8986:aca2:c560%3]) with mapi id 15.20.4566.022; Mon, 4 Oct 2021
 10:27:52 +0000
Subject: Re: [PATCH 1/3] amdgpu/pm: add limit_type to
 (pptable_funcs)->set_power_limit signature
To: Darren Powell <darren.powell@amd.com>, amd-gfx@lists.freedesktop.org
References: <20211003044658.29238-1-darren.powell@amd.com>
 <20211003044658.29238-2-darren.powell@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
Message-ID: <bb5cc6d3-172a-8192-2dfc-5071dd73572e@amd.com>
Date: Mon, 4 Oct 2021 15:57:39 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <20211003044658.29238-2-darren.powell@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BM1PR0101CA0031.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:1a::17) To DM6PR12MB3930.namprd12.prod.outlook.com
 (2603:10b6:5:1c9::19)
MIME-Version: 1.0
Received: from [10.252.81.250] (165.204.159.242) by
 BM1PR0101CA0031.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00:1a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.14 via Frontend
 Transport; Mon, 4 Oct 2021 10:27:49 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c5091682-d1a1-4fcf-7789-08d987219ec3
X-MS-TrafficTypeDiagnostic: DM6PR12MB3932:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB393260806F8F1F91BAFF23FF97AE9@DM6PR12MB3932.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:24;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3f+K/h0QJ4zfKFOeom+VuqZcozSt0ZTU6OYQMeaCwyu+gff/OcdLRILh3M95tkf8JXXTy+MaXfmBzKaxR1fsWDffXyREoSi4Ae/K/N0IM7VcPNpWMDNE2Ao1tYKcu0qq4c/3WjMgZjwiWPi16kj4LZOz21z5rLCDfQKsRmhI5kfQCydWKjCbiL8oMBmzFE9ofDdIfudmS3auom7xZBnp6paj0zBqp9a72jZBA+6KGXehd5bSFqG80hXlfDVEgEeyB7H7skJc6xB1XDlROUrBhmGpfuYvxSC2R+8LawwOIClqbJwo8PBFAT4ZCO7jvpFsyh0rb9dVyOCWQmXA7b04UVYcYKWLrnCSoWuvll/xVUIQl+k5wNFO/erDNYrA7CVQPNUg0CQd6lGGVrlB6/hHrW87cnj2WCKxQTrdlI/1v83ZaNran19pXXwYqRUKmt7ikNhURYkvjOXGk6Gp+G9M+JOmGWiUD+nQkoLm2zjGtZDKkEx2FWEeNzedrQit/c5lKS1waW1LBVVSI1uc4qi6aGzFLUbI7z26u0cUQ30z91jsrIGLOnQOWyKPCtjzFA/0MPi+nIQ/GcTgxxebl7Yit4Gxv5uH5suLWCokQBZe0XHAXiwmeZENEHT7RhJY01anWjtB0Q1DAptZBWLwDn8/0GPX1w8IZ7vpklCZkP0gCM66SwZgGjPr/n+q1HtRSdaNRa7xNOUGGSe0377OJGX3lR3oFB4p+qUNw3Ohq0iAr3I=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3930.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(86362001)(26005)(36756003)(6666004)(186003)(66476007)(66556008)(53546011)(508600001)(6486002)(66946007)(5660300002)(83380400001)(2616005)(8676002)(31696002)(38100700002)(31686004)(316002)(16576012)(8936002)(2906002)(956004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VnFBMm85aUlCbHdqMTdZbGZpRG1TdEtud0ZnaUVVdnIwZEdKVEdlYzM1a2t0?=
 =?utf-8?B?Y1crVGFTUGtCOFk4UGRFRHNDcG95YUVORGtsbXFlMDdLbWU0NTZKSUZTeTVa?=
 =?utf-8?B?bldha2l0UHRtVVZFM3NraG9tczZhdGdhVVFNemlpb2kwdTlwd09Ra3Iramd6?=
 =?utf-8?B?Y3RTT0JOY1loOThEQ3hsa0kyU3pway90amF6VCtDVFpEQWhqa3JuVk43blo2?=
 =?utf-8?B?K1FrcS91WUFtQ0NMa1JPemdCRXB3N3gzNWtSMllNdWdrZ0F0bWhnaTd6VlRP?=
 =?utf-8?B?Nkw5dDRNSVNybytSWDh6bmxVaEdjbDA3VkhUVFdLOThhOGwrSEp0OXVxSUha?=
 =?utf-8?B?OURKYVFRTmdOSk5pcHczRDNGSVRTY1dUclYyc25WSDREWmVmVG82QS9reGIz?=
 =?utf-8?B?M29aUjZYSFh2MEFidTBjZExRTitjaEw4c0RVYU9JVSt5c0tEQ2lhdERSQStC?=
 =?utf-8?B?eGZvdHh2ZUw3N3phaTlIdVNZMnVGWkY2RzFocWVYNXRubWxoS2Z4ZldUeTY1?=
 =?utf-8?B?enlKZlk0OHNQMnpuMUpHdDExZTlUam1qWnhwNW04NWNXaWZkNS9KMWQ0OERl?=
 =?utf-8?B?YXFCdzVlMkpCTVZrS2RlL01VQmZTcjNhTUVJQ1MxVzJRQnFuVHR3aitLd2x6?=
 =?utf-8?B?Tmc3R01Da2VycGFhdHhhOVVGM1FabHZYWXhoSHVvYVQzTkYxSzkyQlJ0V0d0?=
 =?utf-8?B?MkYxVU5DV01wS0J3aVhwNWlaN3VlWXBycEVLZkZkNk1OZS82SEUvTDNBTkZI?=
 =?utf-8?B?a1RpYXltR0dhSG4wVFNqRXdqVFZDNkd6NVI2MjIxMFZxUW1UeE1EVjh0d0JD?=
 =?utf-8?B?RXJYUGpmYzJYTGwxU3FUb01DbmI1YlRkK0FSb0VGcnhxcWNETDQrTy9TaE5X?=
 =?utf-8?B?bU5sS0NUSEZUN0JFaXpHN05CM2xtd2RFclUzOGprczNqVllkT2lxbHd6VEZl?=
 =?utf-8?B?Mll2NVRFZmpqeFNuMGprMjJIK09YT1hacHlUTE00a2lzdWM5SXQwblkrSTRX?=
 =?utf-8?B?R3BxUGFZZUZWdjVzNnhmK1MvUG01Q3BUdFRhTlpmM1lMK3RMb1lHeVBaSUVQ?=
 =?utf-8?B?aFpFd3F6K0hxRHMwc3N0QitZRFpnQy9xMS9CdFBRQml2TGxTamJ3NVBXNENk?=
 =?utf-8?B?dGdvc1FMVzgrVzZWT1BlcWc0VEsyUG9EUi9vNzJ6UjE1NmxLNkJjaFNqOU0w?=
 =?utf-8?B?YnBtUzdYb1I5SDFXNFlxb2pJNitlRDJXdUhMOWx3WER2aDR4WThXeTMvTHV3?=
 =?utf-8?B?a1FqZjRLOFhOVXZVZjFtTWJURDYzREFnK1oxMHRyaWR4NElIMkFjMm9Jd3hL?=
 =?utf-8?B?ckZ4RTVtYjZHS0JacVZuQkpNZlBQa2hJTjJxL3VCMStkV294cGZZeEtRd1NP?=
 =?utf-8?B?RmpWb1N1WEVDM2lIeFhHQitIb3BqYVRZckttUVRuKzBndFBpaWpnc3VQa2Ew?=
 =?utf-8?B?eUFOZm1hN2xiUVp5bmJtbFBhK3lKZmE4UW9kdEdGOGdCc2E4NjR1dGdrQTBO?=
 =?utf-8?B?MWlIRkFkQ0N3VXAyTTlvY1VNMGpXNFQ1cWdramd6eStlZ0pJTVZnaTNJTHB2?=
 =?utf-8?B?eHV6aE1uaWpxc3pYaFlDMGNHaGV5TEt0aDlCcXFkQzkyaVdDcjZkVHhkNmY1?=
 =?utf-8?B?UjVJWUIrS1BrYjFOTVdNaGRkRkY1d3JGL0h1RU50VTJZSFNTNFk5S1JLb3pu?=
 =?utf-8?B?TWlYSkhkVktXT1Jjb1ErQWlHN2dPUDA1bkNMLzBZRjgyWUsyWlpXaDFUTVVS?=
 =?utf-8?Q?hhuUUdF0WhZ1krpxC5q6n6Nm6Q8c16a101Y58sI?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5091682-d1a1-4fcf-7789-08d987219ec3
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3930.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2021 10:27:52.0834 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wHmTGRayeHneFMNByiUfpirsknWI46TMswrFJK0PkI3TS5fo+e4rj175Xw/Tgs9f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3932
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



On 10/3/2021 10:16 AM, Darren Powell wrote:
>   modify (pptable_funcs)->set_power_limit signature
>   modify smu11 set_power_limit signature (arcturus, navi10, sienna_cichlid)
>   modify smu13 set_power_limit signature (aldabaran)
>   modify vangogh_set_power_limit signature (vangogh)
> 
> === Test ===
> sudo bash
> 
> AMDGPU_PCI_ADDR=`lspci -nn | grep "VGA\|Display" | cut -d " " -f 1`
> AMDGPU_HWMON=`ls -la /sys/class/hwmon | grep $AMDGPU_PCI_ADDR | awk '{print $9}'`
> HWMON_DIR=/sys/class/hwmon/${AMDGPU_HWMON}
> LOGFILE=pp_show_power_cap.log
> 
> cp $LOGFILE{,.old}
> lspci -nn | grep "VGA\|Display" > $LOGFILE
> FILES="
> power1_cap
> power2_cap"
> 
> for f in $FILES
> do
>    if test -f "$HWMON_DIR/$f"; then
>      echo === $f === >> $LOGFILE
>      cat $HWMON_DIR/$f >> $LOGFILE
>      RESTORE_VALUE=`cat $HWMON_DIR/$f` 2>&1  >> $LOGFILE
>      echo RESTORE_VALUE $RESTORE_VALUE >> $LOGFILE
>      echo 120000000 > $HWMON_DIR/$f
>      sleep 3
>      cat $HWMON_DIR/$f >> $LOGFILE
>      echo $RESTORE_VALUE > $HWMON_DIR/$f
>      sleep 3
>      cat $HWMON_DIR/$f >> $LOGFILE
>    else
>      echo === $f === >> $LOGFILE
>      echo File Not Found >> $LOGFILE
>    fi
> done
> cat $LOGFILE
> 
> Signed-off-by: Darren Powell <darren.powell@amd.com>
> ---
>   drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h            |  4 +++-
>   drivers/gpu/drm/amd/pm/inc/smu_v11_0.h             |  4 +++-
>   drivers/gpu/drm/amd/pm/inc/smu_v13_0.h             |  4 +++-
>   drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c          |  5 +++--
>   drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c     | 14 ++++++++------
>   drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c   |  7 ++++---
>   drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c |  6 ++++--
>   drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c     |  8 +++++---
>   8 files changed, 33 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
> index 8156729c370b..3557f4e7fc30 100644
> --- a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
> +++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
> @@ -1008,7 +1008,9 @@ struct pptable_funcs {
>   	/**
>   	 * @set_power_limit: Set power limit in watts.
>   	 */
> -	int (*set_power_limit)(struct smu_context *smu, uint32_t n);
> +	int (*set_power_limit)(struct smu_context *smu,
> +			       enum smu_ppt_limit_type limit_type,
> +			       uint32_t limit);
>   
>   	/**
>   	 * @init_max_sustainable_clocks: Populate max sustainable clock speed
> diff --git a/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h b/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
> index cbdae8a2c698..2d422e6a9feb 100644
> --- a/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
> +++ b/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
> @@ -197,7 +197,9 @@ int smu_v11_0_notify_display_change(struct smu_context *smu);
>   int smu_v11_0_get_current_power_limit(struct smu_context *smu,
>   				      uint32_t *power_limit);
>   
> -int smu_v11_0_set_power_limit(struct smu_context *smu, uint32_t n);
> +int smu_v11_0_set_power_limit(struct smu_context *smu,
> +			      enum smu_ppt_limit_type limit_type,
> +			      uint32_t limit);
>   
>   int smu_v11_0_init_max_sustainable_clocks(struct smu_context *smu);
>   
> diff --git a/drivers/gpu/drm/amd/pm/inc/smu_v13_0.h b/drivers/gpu/drm/amd/pm/inc/smu_v13_0.h
> index dc91eb608791..e5d3b0d1a032 100644
> --- a/drivers/gpu/drm/amd/pm/inc/smu_v13_0.h
> +++ b/drivers/gpu/drm/amd/pm/inc/smu_v13_0.h
> @@ -163,7 +163,9 @@ int smu_v13_0_notify_display_change(struct smu_context *smu);
>   int smu_v13_0_get_current_power_limit(struct smu_context *smu,
>   				      uint32_t *power_limit);
>   
> -int smu_v13_0_set_power_limit(struct smu_context *smu, uint32_t n);
> +int smu_v13_0_set_power_limit(struct smu_context *smu,
> +			      enum smu_ppt_limit_type limit_type,
> +			      uint32_t limit);
>   
>   int smu_v13_0_init_max_sustainable_clocks(struct smu_context *smu);
>   
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> index a2a2a8398cd7..faa78a048b1f 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> @@ -2342,9 +2342,10 @@ static int smu_set_power_limit(void *handle, uint32_t limit)
>   
>   	mutex_lock(&smu->mutex);
>   
> +	limit &= (1<<24)-1;
>   	if (limit_type != SMU_DEFAULT_PPT_LIMIT)
>   		if (smu->ppt_funcs->set_power_limit) {
> -			ret = smu->ppt_funcs->set_power_limit(smu, limit);
> +			ret = smu->ppt_funcs->set_power_limit(smu, limit_type, limit);
>   			goto out;
>   		}
>   
> @@ -2360,7 +2361,7 @@ static int smu_set_power_limit(void *handle, uint32_t limit)
>   		limit = smu->current_power_limit;
>   
>   	if (smu->ppt_funcs->set_power_limit) {
> -		ret = smu->ppt_funcs->set_power_limit(smu, limit);
> +		ret = smu->ppt_funcs->set_power_limit(smu, limit_type, limit);
>   		if (!ret && !(smu->user_dpm_profile.flags & SMU_DPM_USER_PROFILE_RESTORE))
>   			smu->user_dpm_profile.power_limit = limit;
>   	}
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
> index 3470c33ee09d..aedaa4bb15c2 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
> @@ -978,7 +978,9 @@ int smu_v11_0_get_current_power_limit(struct smu_context *smu,
>   	return ret;
>   }
>   
> -int smu_v11_0_set_power_limit(struct smu_context *smu, uint32_t n)
> +int smu_v11_0_set_power_limit(struct smu_context *smu,
> +			      enum smu_ppt_limit_type limit_type,
> +			      uint32_t limit)
>   {
>   	int power_src;
>   	int ret = 0;
> @@ -1001,16 +1003,16 @@ int smu_v11_0_set_power_limit(struct smu_context *smu, uint32_t n)
>   	 * BIT 16-23: PowerSource
>   	 * BIT 0-15: PowerLimit
>   	 */
> -	n &= 0xFFFF;
> -	n |= 0 << 24;
> -	n |= (power_src) << 16;
> -	ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetPptLimit, n, NULL);

Since limit_type is introduced as arg, could you also add below to 
smuv11/v13? Currently, anything other than default is used only in vangogh.

	if (limit_type != SMU_DEFAULT_PPT_LIMIT)
		return -EINVAL;

That will also avoid any 'unused variable' warning.

Thanks,
Lijo

> +	limit &= 0xFFFF;
> +	limit |= 0 << 24;
> +	limit |= (power_src) << 16;
> +	ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetPptLimit, limit, NULL);
>   	if (ret) {
>   		dev_err(smu->adev->dev, "[%s] Set power limit Failed!\n", __func__);
>   		return ret;
>   	}
>   
> -	smu->current_power_limit = n;
> +	smu->current_power_limit = limit;
>   
>   	return 0;
>   }
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
> index f6ef0ce6e9e2..eba516428f1b 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
> @@ -2144,11 +2144,12 @@ static int vangogh_get_ppt_limit(struct smu_context *smu,
>   	return 0;
>   }
>   
> -static int vangogh_set_power_limit(struct smu_context *smu, uint32_t ppt_limit)
> +static int vangogh_set_power_limit(struct smu_context *smu,
> +				   enum smu_ppt_limit_type limit_type,
> +				   uint32_t ppt_limit)
>   {
>   	struct smu_11_5_power_context *power_context =
> -							smu->smu_power.power_context;
> -	uint32_t limit_type = ppt_limit >> 24;
> +			smu->smu_power.power_context;
>   	int ret = 0;
>   
>   	if (!smu_cmn_feature_is_enabled(smu, SMU_FEATURE_PPT_BIT)) {
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
> index 5019903db492..59a7d276541d 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
> @@ -1241,11 +1241,13 @@ static int aldebaran_get_power_limit(struct smu_context *smu,
>   	return 0;
>   }
>   
> -static int aldebaran_set_power_limit(struct smu_context *smu, uint32_t n)
> +static int aldebaran_set_power_limit(struct smu_context *smu,
> +				     enum smu_ppt_limit_type limit_type,
> +				     uint32_t limit)
>   {
>   	/* Power limit can be set only through primary die */
>   	if (aldebaran_is_primary(smu))
> -		return smu_v13_0_set_power_limit(smu, n);
> +		return smu_v13_0_set_power_limit(smu, limit_type, limit);
>   
>   	return -EINVAL;
>   }
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
> index 05c5e61f3506..58d837d9a414 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
> @@ -945,7 +945,9 @@ int smu_v13_0_get_current_power_limit(struct smu_context *smu,
>   	return ret;
>   }
>   
> -int smu_v13_0_set_power_limit(struct smu_context *smu, uint32_t n)
> +int smu_v13_0_set_power_limit(struct smu_context *smu,
> +			      enum smu_ppt_limit_type limit_type,
> +			      uint32_t limit)
>   {
>   	int ret = 0;
>   
> @@ -954,13 +956,13 @@ int smu_v13_0_set_power_limit(struct smu_context *smu, uint32_t n)
>   		return -EOPNOTSUPP;
>   	}
>   
> -	ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetPptLimit, n, NULL);
> +	ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetPptLimit, limit, NULL);
>   	if (ret) {
>   		dev_err(smu->adev->dev, "[%s] Set power limit Failed!\n", __func__);
>   		return ret;
>   	}
>   
> -	smu->current_power_limit = n;
> +	smu->current_power_limit = limit;
>   
>   	return 0;
>   }
> 
