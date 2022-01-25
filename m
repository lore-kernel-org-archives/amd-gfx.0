Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99066C433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Jan 2022 15:31:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EB5F510E38B;
	Tue, 25 Jan 2022 15:31:34 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2089.outbound.protection.outlook.com [40.107.93.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5B4FB10E38B
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Jan 2022 15:31:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TfRf/v6YFCICPM7b+FJwSfpjRdIF+gVpFF9ZkzjMFyRQi4YpOeRqRlajjCbYm0CFxtV3QW9UKNb0owNmt+BETWi6Y+SkCvhv9bWim6Ij+GyPdyPnaAh9naVVjq+SDH3+iIGyK66c7+yS4/rG2EmWNgcvW2fRjCdrqFzo4rRrWOjNROWLOiKXh8ChmlqnGLiKglaBjTxKYPI/mJyXh042Du9HyoHsaxEPsDI9oulMLhsYRYIg3A8hyzoXoqnHUJfP49U/KENQP8h4XnjCFF/32Y2H3/E54YtWRTXKLMRzYAB+vcPubblUvlumeRuzg50Ehqd+LlzdgDpURl0YVh9htg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VC11cxJT7gNtX5hiSn1hzd1Leb401bZmr4qAIDX39oc=;
 b=ar9zKl2lnIhp9Tj4L9Y3nyrMxojCFfB4fgsrl+d+yBxr3wvMHJFEP9SawP2BsHly4CJc26LLWzbXi6aU9RuAhViURj7CqIIZFGyY3C8yGhsVGSv0rS6xiSeREwITijZbvHRVKpvj/CcDZx32czLr3Xd02DtMGdkLkxHti7D/IDuyCZTMnrnVT5g6sKdwZCyHo4Xdu7G7yAd1eeu+kUjhf9/WjlITG+N8FjeqjNYTae2M1wNS84ehZYAKTFTVTPkNRUGL9FgsrbZs3mqldAYvRxL3rziadvYMUewR0/FbhUCM7Z3iSeCQ/MuyCz2bme7EBEL/l35K2yy31w9NKTnWSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VC11cxJT7gNtX5hiSn1hzd1Leb401bZmr4qAIDX39oc=;
 b=RGzXYM/Nq+x1ulS276b3mSVer7gPhT6+g8+xcI/ao+nC/oCmPlqTqxTQ3eaT8x7Uc4ecNqATzUusYngHH2GPTOJAXx4LENFNuXWWMna7uhSXEZwF8fLT1k/X55KYM8tdbYcCSXrnDsWrcCT+kVJ+lH85GYu3Z/kjqyxNd2PXse0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by BL0PR12MB2820.namprd12.prod.outlook.com (2603:10b6:208:80::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.8; Tue, 25 Jan
 2022 15:31:32 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::971:531c:e4f4:8a9a]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::971:531c:e4f4:8a9a%7]) with mapi id 15.20.4909.017; Tue, 25 Jan 2022
 15:31:32 +0000
Message-ID: <b5fab406-062f-1fdb-832b-1ba0249e1e10@amd.com>
Date: Tue, 25 Jan 2022 10:31:30 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] drm/amdgpu: Fix an error message in rmmod
Content-Language: en-US
To: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>,
 "Yin, Tianci (Rico)" <Tianci.Yin@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20220125100321.450194-1-tianci.yin@amd.com>
 <SJ0PR12MB54888020E0D600D546BAC634825F9@SJ0PR12MB5488.namprd12.prod.outlook.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <SJ0PR12MB54888020E0D600D546BAC634825F9@SJ0PR12MB5488.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT1PR01CA0147.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2f::26) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a5f2f261-94b1-4f4c-eb6d-08d9e017c394
X-MS-TrafficTypeDiagnostic: BL0PR12MB2820:EE_
X-Microsoft-Antispam-PRVS: <BL0PR12MB282097184D6555BFA489F7DA925F9@BL0PR12MB2820.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HfzVsA04ME1QYAypWydKkTtuZgYyt4fy4cO32Qr7Bq55OWTxLi7JHkKnIN/zrFQeGGbEGZrSNBT1byq1/joVk+SEuo9iQY4TMwn1ZyXWsHiPSz7u+CNk49mUdHhJzfx1QZbMqgPt/EvUcCUXQyyasB01iycZer7t7LKE8BeQwW83BzPNMPJdTI3LMrlZ5cR7i9t+nzRiI08apokaNBNYVOQ0oPyvlUp8LYZZWMLqnbrZQQZyA63WFWgMCLYnIvyAzEZPLt6+967SiR3PZOKahgbdRSo1NzSHTDpQSOocuIkhaKmChgPPxV40wXK/dzxCN43isUnYM5Tls+YwzLHDQsu3h4aUG0RwHH/W4tXzqYdAkVvLhkU6cc5CwhcFUGHKMN/CZb6/uSKWUgD0PnSrgMRlL+6ds8itl3ObVRO8tQGrIjm0mtWjCPdAGO3v9FpBxVhjUnIyXooXgXttV2wd2bRn9M5VUQuNENDNhWvWTzXtCmVUPWF/IlHJ6npgDVCwaA4JY29B5Wk5QFzgkUl3ZhcS9or0SV4gyteIugzsAAYeeOxvKh6eNG5o1Ssw1OCoLbOEiT4yP8IU59MWkZ+YLNZ2Ju8u2XVezFp61aAZd/TANg8n77lNDNxrVasBtwS5cYn0TCSfxhuqd3HAZ0vvhvqEbJGQXSDeoS5FFrdSkrSDJjTrHjMCSfBjSnHazaahI/WD+qy3cp0/7YtJ57G5m4xkfYiluHjPhn7/5AsK3v+rcEBQ2ISNVLq2J7KT5NhY
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(8936002)(86362001)(66556008)(31696002)(508600001)(66476007)(66946007)(54906003)(44832011)(4326008)(38100700002)(2616005)(316002)(36756003)(83380400001)(8676002)(2906002)(6506007)(186003)(31686004)(26005)(15650500001)(6486002)(110136005)(6512007)(5660300002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WjR5Sy9sVGZLRUloSEhteFNWbUo4QnQ4NEN5N25qbFYzZWpYbi8wR2NZdnRo?=
 =?utf-8?B?d00vU3Ivb0hzc0pNQlpyNzJlTTcwcHBzSEpRc3Z4NUpjQyt0UkwvaW5IdjQ4?=
 =?utf-8?B?dGhTaGFlUWJtZDBocnN0Zm52eXp4cW9LT2Y5VFRhSHJ1a2tOWFlIUzhkLzg4?=
 =?utf-8?B?ZmVlWU1KbzR0TDNuVTRDbjFka0NjNnhKNThGcUxiU1AvcWxzVUVocW0xZVRI?=
 =?utf-8?B?WXIxUEl5NE43V2FkNEcvbUpDL0ZKMUtQT3FuZnhDRVN2YW82RUtzL3Q1cCta?=
 =?utf-8?B?cUg1dVp2bGdCSlpDZzZXOHBEdVNwazl3bjR6OXgyelI0N2hiNmNiLzJ4Zlkx?=
 =?utf-8?B?bTk0aU5RWk1vekVFemdhY256U0dtMmZ2QXZqNzhHWm0vN3Vmc1h5ZFNuREhz?=
 =?utf-8?B?UjNmQmNla21WUHZnVFNMQVMwcDlWblo3VUVUOXdyTkJBY3pUMjhlMjQ0Z0s2?=
 =?utf-8?B?Vy9nSmdGVmZtanh0eElsdkRVdys0VXJLbmZSMmlrZjJxTXpaM2trM2p6azJ1?=
 =?utf-8?B?bWk0d0s5R0xFTDlhcFdPOUlNcDgyL0FQVHhMQ1JFQWl0UFRZNEFJNmRSL3Q1?=
 =?utf-8?B?NFJDZTlva2hVN05qOW5vYkwzMzNtVmwySExwd0lDUWJrNE1WSkRYUkZET2pH?=
 =?utf-8?B?SVpxaWZmcHozQSs3a1J3eERXbWZuVksrTDJ6eldiK2JWVzF5dVVTZy9zVFJj?=
 =?utf-8?B?M3BveXdqSjVqMWhNNmZWbXd1R1BxK0NDVzByZWJKOFIyZmFRdFNSbHlQVG1j?=
 =?utf-8?B?ZFM4dGJEK2MweU9EdENIV2hiMDlQcEduYkFvdHpZYTJGQm9yMzlSSkpMV3dQ?=
 =?utf-8?B?RHpIbUswTE1rNi9uSW5MUkI2cG1hL0tTemo4YnBaTElWZHFoUXhOZFdoaCti?=
 =?utf-8?B?bU9sQ0EyRXJPa20wRXM4eVpnMDJjRU1COEJRYXZPQkZVd0xJWGJ4M0NaZlNa?=
 =?utf-8?B?bXE0VTRPVitWYUNyREo5MmhRaGFNa2hDS3o2U0RuS3FVa3lHQ01OV3IvZG5Y?=
 =?utf-8?B?NkdCeTZ6UytYamo3TzJGdU9Cek43aFA5Yk1LRUo3SDNIdkdTL3B2djliMFlk?=
 =?utf-8?B?TG9FbWtBVDZqMmFNQk12cW10WUU2ZTN6NXN1SFhFRE1vWkEzbWpyOUtKaDNu?=
 =?utf-8?B?ZFhTdEMwNjRGRkR6S05PZGI5ZmJzQ2N3dWR5aUlXbkU4d1k0ZFdjaTdwRWNV?=
 =?utf-8?B?ZWtaa2ZKOW9IMC8xd3VUd1NkVHZkNmNNcmdpbW9oVTVMTzBVemJQOTNOaEJ2?=
 =?utf-8?B?d3p4Z3BFbzZ1UVRUVE5oenJONW15eTRJK21rUk9POXlPVGxRcXRrTmorejEw?=
 =?utf-8?B?UENkb0ZRZWJNb0hIYW5PYTkyZStOQmVoVTYzcWNQY2VNZGJyaThJMGtYMEpx?=
 =?utf-8?B?Rjl6QWcwclVZbzVUZ3MvWEFpWE1RdjI2RlFqcGdDRklLbUZqaEROdkhHdnNH?=
 =?utf-8?B?aVV3QThCUWtQUHJjRFlMSlJwVGhRajRucWE4ZTVNUjhqS00yN2FWYzkyY0FK?=
 =?utf-8?B?MHU5ejhZejRLM0o3N20zWTJhSUZyMGpQVXgvUHg0N2ZSdmtLVGk5Y3BRUmtF?=
 =?utf-8?B?dDJ2VFo4aUIvVyttdy9VTkxFU2VHblJZaTBHbzgyRDdMcXY5R3Qya3F4TXFD?=
 =?utf-8?B?c25BSGJXaVZ2QWFDSWVqMkRLY0xpTE1VVnNqUlNjdXp5QStEeGFBaG40b3FG?=
 =?utf-8?B?NEVBM1FxRzl2Y21aS3FsUVRmOXhDQXgzOWI4V2NkVjNSbjlXajVMY1JOdjJ0?=
 =?utf-8?B?MzlIUG8vRldGWEFBTFpvTUdHWVFjSnVFVU5OVS9aMjlodHNZaHZIOUFLUnFJ?=
 =?utf-8?B?NWNqd1h0UGpodFNsRTJ3VDZTKzlrVElMZlV5aTFybmRUb1VOaWJPdC8wMlQz?=
 =?utf-8?B?S2FraFg3cmpDbWJwOEdnRXBpb1BvUlVQcGtaOTBnd3o2c1V3M0NjRHM1NEhn?=
 =?utf-8?B?SmgvbEREQWxNRVBlSCtuK3RVckpqaXYxNmJVT0JqK1U3Yit0b0FtWHlWU3lL?=
 =?utf-8?B?Wjc4T0lGYVRURzZ4ZFIrTmRMZkw4aEZ0NE9DUVBFY0hVZ25xajZ0Y1VTM1o2?=
 =?utf-8?B?amZNWG1BTFo1d0JaQ1pZbTNpSG1zKzNoUlFGa2xIdzJIbTJzdDlzNEZLMi9k?=
 =?utf-8?B?VEphdEtCdzdNaXdmUjQwQUFKUHAyZ1ZwRU1jSVdNbENKMDRpdWFwcDVPd0tM?=
 =?utf-8?Q?S86iIFyxorUyaPBHeXLN9As=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5f2f261-94b1-4f4c-eb6d-08d9e017c394
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2022 15:31:32.2165 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HUOLVIiOGUuKRQ7Q3NzsOfWHz1jDKeqgkzq8wr9CnZLb4eUxWW7Gl94hE0Av5HabayG32RSfHrwghXKcDDsKtg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2820
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
Cc: "Grodzovsky, Andrey" <Andrey.Grodzovsky@amd.com>, "Chen,
 Guchun" <Guchun.Chen@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

I have no objection to the change. It restores the sequence that was 
used before e9669fb78262. But I don't understand why GFX_OFF is causing 
a preemption error during module unload, but not when KFD is in normal 
use. Maybe it's because of the compute power profile that's normally set 
by amdgpu_amdkfd_set_compute_idle before we interact with the HWS.


Either way, the patch is

Acked-by: Felix Kuehling <Felix.Kuehling@amd.com>



Am 2022-01-25 um 05:48 schrieb Wang, Yang(Kevin):
>
> [AMD Official Use Only]
>
>
> [AMD Official Use Only]
>
>
> the issue is introduced in following patch, so add following 
> information is better.
> /fixes: (e9669fb78262) drm/amdgpu: Add early fini callback/
> /
> /
> Reviewed-by: Yang Wang <kevinyang.wang@amd.com>
> /
> /
> Best Regards,
> Kevin
>
> ------------------------------------------------------------------------
> *From:* amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of 
> Tianci Yin <tianci.yin@amd.com>
> *Sent:* Tuesday, January 25, 2022 6:03 PM
> *To:* amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
> *Cc:* Grodzovsky, Andrey <Andrey.Grodzovsky@amd.com>; Yin, Tianci 
> (Rico) <Tianci.Yin@amd.com>; Chen, Guchun <Guchun.Chen@amd.com>
> *Subject:* [PATCH] drm/amdgpu: Fix an error message in rmmod
> From: "Tianci.Yin" <tianci.yin@amd.com>
>
> [why]
> In rmmod procedure, kfd sends cp a dequeue request, but the
> request does not get response, then an error message "cp
> queue pipe 4 queue 0 preemption failed" printed.
>
> [how]
> Performing kfd suspending after disabling gfxoff can fix it.
>
> Change-Id: I0453f28820542d4a5ab26e38fb5b87ed76ce6930
> Signed-off-by: Tianci.Yin <tianci.yin@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c 
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index b75d67f644e5..77e9837ba342 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -2720,11 +2720,11 @@ static int amdgpu_device_ip_fini_early(struct 
> amdgpu_device *adev)
>                  }
>          }
>
> -       amdgpu_amdkfd_suspend(adev, false);
> -
>          amdgpu_device_set_pg_state(adev, AMD_PG_STATE_UNGATE);
>          amdgpu_device_set_cg_state(adev, AMD_CG_STATE_UNGATE);
>
> +       amdgpu_amdkfd_suspend(adev, false);
> +
>          /* Workaroud for ASICs need to disable SMC first */
>          amdgpu_device_smu_fini_early(adev);
>
> -- 
> 2.25.1
>
