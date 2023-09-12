Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58517CA0EC6
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Sep 2023 00:55:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 051B710E029;
	Tue, 12 Sep 2023 00:55:46 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2080.outbound.protection.outlook.com [40.107.220.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2AAF310E029
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Sep 2023 00:55:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cwr6CaY8CSXq5Bd9W4iEjG+s5PZfrQAPYZAZ9BtdcQCArAOo8JCIKqrg1hEgAp4dC6wT11B838IF7FzGNbWI6ENtfw04HifbRw3j8Ro4P6+6wkowzWuPz4VxmDlceZmD/E2nJ0ZMDz/agJiJ4YLIHjNJKQFHE7eBW4D41/MDhw9jNScYSR+SAxH8UeTydCvAEW97rnfs584JvxdOIyHQefZLONKSWawCp/gpGcTz2ZXuk7yplKY/c7szL9WK+nUzaaP5JJBR9jMPCEAYb0wN86JH8JumValcVursMNAJx5Dqgt1VkqJk6nRnF1icL0B28LIT8WIYg6PQFSAe04doBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XMUtcW4yy65bsXLZ7sJPHcIBQA2KerydoQFLgIkQaTM=;
 b=VNEd/FXV5l507IKW8u0fyxYr1UGdIJQFq/5jMzutA++yR2ZbXsc1fcUAki0tPc+N2IG9ujKTCqFfJiHAYj52KwCDU/ekgABVhqGBAqo5vL7T3Keciay7+4gekvkp2M4hmqbAzavWgv5ezOOjyUIPnv5Kuutg1PXB2ZaYYeU4oahlzOPseimvt0yd6qRodu2Wpnmr8c/MvRi4Pyo5jTp+BEDYAUFy2z8yZrwNr/uK9JCnT74u2RE+yWkIuPMYBjdy+5bulNloeMsNmXZpgMGi/jJ4dl5J3zkbEQYMHGhJ/8Pf+SvlhmoG/DqgDD7zPw8WexR5OJjGdZyoM6w/UGOVgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XMUtcW4yy65bsXLZ7sJPHcIBQA2KerydoQFLgIkQaTM=;
 b=NghZtjy1ag3l4Nd3hx5cgP1wslaLo6G7wM7vutoRIYFuyR2gR6Vx5UIIjpBtpTGY/6e3zO0Hb7uEzHYAZG0kZuUQHuNCD8BouMSP6zUCg2Im9fy3sN4O+yiaI5nSjtTm/YyWPMa+kU14v+tCUoBcoq5g37FMWj3wYNI64RQpVik=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by PH7PR12MB6417.namprd12.prod.outlook.com (2603:10b6:510:1ff::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.34; Tue, 12 Sep
 2023 00:55:39 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::620f:8aa7:43d6:8010]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::620f:8aa7:43d6:8010%6]) with mapi id 15.20.6768.029; Tue, 12 Sep 2023
 00:55:38 +0000
Message-ID: <e3be9feb-0eec-e3c6-dd77-890d584ccc50@amd.com>
Date: Mon, 11 Sep 2023 20:55:36 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH] drm/amdkfd: Insert missing TLB flush on GFX10 and later
Content-Language: en-US
To: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20230911190023.193702-1-Harish.Kasiviswanathan@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20230911190023.193702-1-Harish.Kasiviswanathan@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQZPR01CA0107.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:83::19) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|PH7PR12MB6417:EE_
X-MS-Office365-Filtering-Correlation-Id: 500e5161-ced6-42e8-1649-08dbb32afb38
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: W529XpGJxijCG77fjrdPQTrMBE9770L3SCt2SSqMpoM+pGm/CXPivWMTklROTebInqsaFM7iLuOnFhVCntfwvFjMAPBZfbYZ1EM76i2afp1tzFyBiWjDAI6XzudUpWniqwF2z7Kt053mpsdbpcmbbLhIUUOzbx3xDYio6YskXhC2MlIg+7E2dONtzdMYI2dCzE2NRy4Yde+TYYLenVgEuYeNvwKxEC41ct/cGOgmaEV9zzuBKRtMQYbbnXdtGohdW+qdYxCHZRiV4z7DzjD/lhRAYIoTEmYDesSWImZwRF7IpRM4l1WfE4zSLssXxlbmius1y7yjL6kScHHcVvSCLG5Sa7pHSXnkPUu8yzwZ5nRWfihU7gSzoodnAZjvevFNhNYGMNVX9aWLQrmp2YXWnEgX/RyXRHo8ReNsJVHnKVaTtPHuPkTBig7Gac0a8b6nAex7vcsXI9psd7NVQ/aEW5BlKW8/L7iKTwVMBz8NDm7rDzj8vt/oM7X7jSkJ1SaYTjK7Fcty4sVzRwcB/2ejL/xhnFWePx7f9ne7bxVx1owgI4HN7sHeE5AKZPrMFm9Do+jmwAiRG4z+QQK168BLwBVW8lomF3fqPWERT1ycmZ6gY3MyknC9JH9jWsmsSLa3jtpjig5MwRKfPnOJ0MTlkw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(366004)(136003)(396003)(376002)(346002)(186009)(1800799009)(451199024)(6506007)(53546011)(6486002)(36756003)(83380400001)(2616005)(6512007)(2906002)(26005)(478600001)(66476007)(66556008)(44832011)(66946007)(316002)(8676002)(5660300002)(8936002)(86362001)(31696002)(38100700002)(31686004)(41300700001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MkY1Y1FocFltOUltYXBiQkdCK2tHT2ZBRFJvaW5pUi96T2JRU3dhL21qRFhP?=
 =?utf-8?B?ajlyeWx0NkYwN1ZjMy83R3hrd0tVYkJOSG1kZ3hKV3ZPZFRiQjZVdDVUN0d6?=
 =?utf-8?B?MFdCblRHaE5HZ3NOQXFSNU5nUEZBQVVMV2kydnZkSHNmTHZwdUtJN3hTMkJJ?=
 =?utf-8?B?ZUIvcmN6UEozTy80WDdTMlZVdXZlVHN5bGw0eVpaRFdJbDAreWxHQlV5KzVs?=
 =?utf-8?B?aWUwYTh1V0dqbXE5eFRZaWtZdE9QaWZVRW0wak8rZlhOMm1pLzlaOWhUWFpO?=
 =?utf-8?B?TWswdVBRblB4US8ycmdDZ1BkR0RQZHlSL0RpQWhqU2lEdHpXM0YzYWtuY2Z6?=
 =?utf-8?B?Y2twbjIrRS9idnliMldYclRkZzZ4dVdlU0d4TUVkRUlCbVgrYlZmNkpNRXlB?=
 =?utf-8?B?TDlNUU5pcVI1ekdGc0RqVzQybkZtT3hlekthWmhxV3JGZ1l3OGlKZEl5QjFW?=
 =?utf-8?B?TEFFUnVWYTJnSDdwL21heXdZbmoxWFMyZVd5N0hBdkovVFdDS1RPcmNaNGZk?=
 =?utf-8?B?MHUxVktSakFCWlZySkV1cGtMNEdXeURQWnoyMU9VOHJ5b1lDRkltSmZrcW02?=
 =?utf-8?B?T3pvTkhUMlZhcVZLcCtiWkJob2E4RWNZZXlmanBCb25nU0tqYUNVVDdzaldN?=
 =?utf-8?B?b1FlMk1GQ2NGM2Yyc1FKeEZZTzVNUUhrUngwM0c2S0NIWVdpTmRiUGVGS0po?=
 =?utf-8?B?SFhzeEJTWCt1RXIrWmRWNmxzRHcrY1FDcHltTEdkMS9Oa1E1VGNJTWZpbkpn?=
 =?utf-8?B?anZrY0pvUHAraDQ4NjdVZE1YRmJIL3Z4aHZFdkVBSlBlcEV0N05vdDFDRWw5?=
 =?utf-8?B?Tk1UQ3RkN2VaMnVQVnBIeTdHQkEvV1JUeCtuMGM2dU1idTlaL2RpOXppZjln?=
 =?utf-8?B?YVhkenBNNzNqbmc2WmRmYkxlYkVTS3RTOGJJUFQ1b1pBV09jTytTVytSVFNx?=
 =?utf-8?B?eGpocWhBTUVTWDJPaktVMWhWRExQeTVuZDBWaHdMTFBYUThNdjIxMHlOeU42?=
 =?utf-8?B?czBrOU54T0tTTGxpWjhjMTEwbGtpanNkL2xCS3RmRHRuL0FaMFhmOTZjV3J0?=
 =?utf-8?B?U3gwOVM4WkROcGptQ3lIN0RLemFyM0xpRU5INldKL0JZWEEwaG9mWk43dW5S?=
 =?utf-8?B?TGd5djZ6OHlkeENsUklnWVVLOTIxZjAzY0FxeTNJY1lvZGdqeVA0bmoxUHJi?=
 =?utf-8?B?NStpd01PdDRzRy9mN1poc2JoWmhXb0tISnlPRXNRaEEvMzBXYlBVUlRBRDVB?=
 =?utf-8?B?WWFHdDJ4clFRRkI3K0JqN2xWS2pWcWdnQVM1bUh1Z1lhWDJSaWtBSlphOGhF?=
 =?utf-8?B?VEpITmlTZklGdTZDQjZwK0J2c1ZOSzVTRUZDSGJyQlF4bG1XQkF5ZDh3cGJC?=
 =?utf-8?B?T21uMkJ6T3RWK0pYeTU0eHU2NFZlUllzTzdSQ1JKUjV4SHkzT2FLQ0MzWXJa?=
 =?utf-8?B?Q2lqTnptbjAzSHJNN25ZQjJ3SWJFd2pHaWg2YjA0eTlLSVpOYWlmd0hud2VL?=
 =?utf-8?B?M2JRNFBkN0N0NWkyVjJ5YVNQL1lDQUF6ZTRaYmtXNHVUWGtXYnZiZ0V1UGRW?=
 =?utf-8?B?Tkh0cVU5QXVIUjBNek93Mzl2S3V4VkhhdldvQkxxbVROeFAzdWdtRXlZdUxq?=
 =?utf-8?B?Y2diUy8veWJFQ21ucTc2UFo3Q2RvZ1JMK0xrcXN4azR0NFpCMEVaS3ZoNmE5?=
 =?utf-8?B?ZkhtbkZWMjFGdVd6RndBbjRpcUQybEZ2T2lrR1QzRklGZUcrWnlQR05hcUxP?=
 =?utf-8?B?d3hrTkc0bmwwdnFoVVhZTXRPRnVkRFZGT1NzRGNmemdVVkxkNnUzdjIxNjFx?=
 =?utf-8?B?Wm52dkFCN3lPb3RpWUYvbGxmWGNpaHU2OW5VUzFuMURsMUJRdUhEdDNOTHI4?=
 =?utf-8?B?ZkpvdWROaXltS1c0bW0zb1pxb0t2aHdyWXcxUnVNTVdFVUhIbGdOUUxkdzR3?=
 =?utf-8?B?aEJGdlo3c0hJYmZpdVFJR2xQUkRqeHI3STk1cHlYYmVDaWhKY2F1VE9tNDlk?=
 =?utf-8?B?QWhqbDcrRUJaZ0c5dmt0dTZTZHArWE9rdC9CY0ZDazFtajJNYVJSRlZad1BG?=
 =?utf-8?B?U2RYa2svUlpMdVUxSDl2RWNSQm5odnRoNStOalp3QXdSZVNBaUJOa01rb2ta?=
 =?utf-8?Q?+yD78x8syufS6wEvc3owLoQH1?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 500e5161-ced6-42e8-1649-08dbb32afb38
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2023 00:55:38.9273 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kA/OmhhvkVPJ5s4bbSt27ylM/Z/nq9rKOhKAkPf5t+6lwKzTZ2AJkwRi+lMvxbRzPuOK9Scdqj9V7AQEJeIezA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6417
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

On 2023-09-11 15:00, Harish Kasiviswanathan wrote:
> Heavy-weight TLB flush is required after unmap on all GPUs for
> correctness and security.
>
> Signed-off-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_priv.h | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> index b315311dfe2a..b9950074aee0 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> @@ -1466,8 +1466,7 @@ void kfd_flush_tlb(struct kfd_process_device *pdd, enum TLB_FLUSH_TYPE type);
>   
>   static inline bool kfd_flush_tlb_after_unmap(struct kfd_dev *dev)
>   {
> -	return KFD_GC_VERSION(dev) == IP_VERSION(9, 4, 3) ||
> -	       KFD_GC_VERSION(dev) == IP_VERSION(9, 4, 2) ||
> +	return KFD_GC_VERSION(dev) > IP_VERSION(9, 4, 2) ||
>   	       (KFD_GC_VERSION(dev) == IP_VERSION(9, 4, 1) && dev->sdma_fw_version >= 18) ||
>   	       KFD_GC_VERSION(dev) == IP_VERSION(9, 4, 0);
>   }
