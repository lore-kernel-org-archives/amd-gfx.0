Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF9F4C43334
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Jun 2022 19:30:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4CE3F10EB1E;
	Fri, 17 Jun 2022 19:30:41 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2073.outbound.protection.outlook.com [40.107.102.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 54F9D10EB1E
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Jun 2022 19:30:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YcvmYiPzcCRz65bbbviLaW8b64wT38EtIv0OUx023faEpctDzCEaH6uFYySP5olNWD4iQRPvZ3OTBZh/sZZjIhS9HoE3/R3h5L/O5nD5yL5SG9brz9mgzHF5PXzLCfxQ4ebOIFIa5w3Zh410UgrgIcIOw43EO+8TsBSaf5U85aaeQjTr36YS5PtzirM+0X9HcwX6ZFDBbpvXqEqZsYAZCvLrbKVwFgapEoPzAX7onn/BHsZcwek2McJ94eM7JADwOngGLnsEczS0/e6vGElAlN/lMp3+QRYh1Hwm3k/c5cO2BaXEpTwEsYMYh6J/XobwrNAcn7nSQNHIVE54Xjav/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LhpCsXm+/AzPApGhUiWJeePrK7CuSwONNBlNhIuKV4E=;
 b=biTrA54wVCu+Lhd56WJo0T1C2Tem3j2Vw4jeikbN9XbH9sq5B1QTeD5Y856N1KS7vCbICMU7G28ZGFAd6aWCh/PHCsH7y+2pQia5zObiMVlS3S/Ybjpqe9I/ZORtA5YXMK5klmt36pgjGvQYV6eteK9kmlU5cVfuVSkHwwSPo36yg8dQUSePiTjDcNlNw3ZMZLGP0WcbVn0obRAc4OZWzINpQxwb2/MDSqgXiaQllWSs5Mh3RC41y2VHI1xK6wX0DQTq5Aqv3KCxnHEHcN73X5J5HA424F/SmHe47OdYW/bLq4YrYg1gL/e6Snizsn6NFHF1e7yNjx0Re8nCfxsI2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LhpCsXm+/AzPApGhUiWJeePrK7CuSwONNBlNhIuKV4E=;
 b=5nTw7AKPoJgwCa79anEGLxQhoPu9qpgw++6aZfYStPFoVvvOtNQL/G3NfEGr2lu0/K/HPSWk0Ioz50MNRa0EWvwkEezknLWonBBmfwcgN6KkICHoSBDnFBMXaajloKuDtuEUyayn856JM1a3KhdqGEe7jWRpByqCsdhRC0e4bjs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5338.namprd12.prod.outlook.com (2603:10b6:408:103::23)
 by BN8PR12MB3156.namprd12.prod.outlook.com (2603:10b6:408:96::29)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.14; Fri, 17 Jun
 2022 19:30:38 +0000
Received: from BN9PR12MB5338.namprd12.prod.outlook.com
 ([fe80::eccd:7014:1fa2:5f47]) by BN9PR12MB5338.namprd12.prod.outlook.com
 ([fe80::eccd:7014:1fa2:5f47%6]) with mapi id 15.20.5353.016; Fri, 17 Jun 2022
 19:30:38 +0000
Message-ID: <bc83dcf3-8396-6fdf-a094-1de75c996481@amd.com>
Date: Fri, 17 Jun 2022 15:30:35 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 1/1] Revert "drm/amdkfd: Add queue to MES if it becomes
 active"
Content-Language: en-US
To: amd-gfx@lists.freedesktop.org
References: <20220617192614.6868-1-Philip.Yang@amd.com>
From: Eric Huang <jinhuieric.huang@amd.com>
In-Reply-To: <20220617192614.6868-1-Philip.Yang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0382.namprd03.prod.outlook.com
 (2603:10b6:610:119::35) To BN9PR12MB5338.namprd12.prod.outlook.com
 (2603:10b6:408:103::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9e9a8adf-2d2d-49c9-8948-08da5097db84
X-MS-TrafficTypeDiagnostic: BN8PR12MB3156:EE_
X-Microsoft-Antispam-PRVS: <BN8PR12MB315658BF2E689E592F4ECF3D82AF9@BN8PR12MB3156.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZJl70XRHyyNdH3CHnRF3jnR1G26M/lMFjYHcYUC1VS6q6yeG0VKmPMfNeLXiHnfQzqbsvnjlNnMFHt1+RuHHPlx2QtuyTiwh1bjm6mo2ilCYTPeH8dUmYo+GkqGnRrD8V51ZltHkLl8pulrO8jYtvqQklZzCxgcIDkDrsV0opZTpLsr3eHC2kUijlg12pQOLz1o/buYnff8CL610ohgzg5hgah5d0ufEIFeURjuHuFEi/zZir4HxFEJIuo48Bqtcwyq954nyGJfCQfQY1RyGlIbmrwtxHwREOw3Hv0lr/CR8vJuC3VwodVL3+bngzsU95d3AhOz5LnidTA3QrTk3oJN0qS1jMasAKJv79sqdElVppazgnKIfEENTTAy313vTXGHbcpXmwquPJbE12473cge/UFBkvsjKVabsfY6QOn7ott087t2BvX7FG1sf3oDRy0JiIsykbJrYsGtgXb6xzmoG0xfJmJzgpRYQxhF8CSr0s9e3fhvy6XCtPd0N/SeTb4GYs2YHxXneXJp+3Izx9xXQAZYyioTU4cVIELFVQIHd/6CfKpQqtmp0nSbXpTsWoDJSRLfKFi74fOhG4ogxbZ4K+sh3xy2s4thTPEt4wi62TqXUK9+ZHSZp6HLi4FE0L5TkWYVKr7p1wmmPp0fnAyuAPgGX/xQ5stjWXk1YbBzzdJvUemouaNdbd8GuIvxX7XZAVnZXIAkMHZTK6kXqLKWDfIkno+0av4Coc4uirVE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5338.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(366004)(66946007)(2906002)(66476007)(498600001)(6666004)(5660300002)(8676002)(2616005)(86362001)(6512007)(66556008)(186003)(53546011)(6506007)(31696002)(36756003)(6486002)(4326008)(8936002)(31686004)(38100700002)(83380400001)(6916009)(316002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cHcyQVduSHM0TzdueWszcWY0RFJKays4em1zczRIakM3WHZHRTVZVXFZbDJi?=
 =?utf-8?B?T2Q5bUlMUUVLVktqWkt0ZGFZdXVRQTIxWjdqdk96OFZVOUZ0UEhmN2oxYWta?=
 =?utf-8?B?cG9lT2paMUd4MjFybnJJTE1FdHZnRXY4NGFCai9HUGMyemx0d1dvQ3NNM3Za?=
 =?utf-8?B?bWlteGx3RklKZ0VNY0dISEovaGJpL0tQR0pxQUxiamh0aUFVWGpyR3JwTGdw?=
 =?utf-8?B?Q0JhbGNsblV0Rkk5M0NCNzV0OW54NW0rM0JVeUFxT3pqd3BwYm9IZ3Rha2xq?=
 =?utf-8?B?SHovL3NhM2ZZeHJuOG9rQ3IwQlFGUXhGeG1DMXRrMDFkZWt1a2RyQThvcExj?=
 =?utf-8?B?Yzc3SHhNYTBlVkdSRjdFNlQzTUlySE41R3doSnltL1ViRnd1b1ZMTlpJaGZZ?=
 =?utf-8?B?ejJ6a0hQb1RmZHQ3MWRVeUtYcDNON0t1NHF6V3hnTjM4ejRxN2N3S1hTWkls?=
 =?utf-8?B?Nzd2bUdna1NrWXA5aE9DdExnem5hdFlFdTJZZDV4YmpJRFVoWTJvT01FNTA0?=
 =?utf-8?B?SGxzV0tVTWpEazZHaUNJUHZkOGEwdUZJK0dMZDVJRUh4Z1hUa05UOGJiYXRq?=
 =?utf-8?B?UCsxeDMxSzRYS082V3A2b1VoRXlYRFhtODFRaXBEUkF6Z3lmYTVwd1dVS0tt?=
 =?utf-8?B?VUVRVS9DM3NXUjFCZlJUVE5mejNHVi9aTHk3aDd4WERwU0p6cTA0dmt0b2xI?=
 =?utf-8?B?Q1NoN3hDVHFwSjc4N1ovQk9XempoWWF5dk1OVkFSTktyTVFNOStvQ1FGZDZW?=
 =?utf-8?B?b0lxaFo2VHRWbGQzVWtkS0VGTjRra3JPSW5ydGFlYkFYS2g5aUJ5V254MU9V?=
 =?utf-8?B?SWg1V2dlUDRPSjVsa0ViWHlMM0RxNkc4WlZVSFRKdm11SHd1WWRpWG5GUlA3?=
 =?utf-8?B?V0Q3U2NOMUN4YTg5a2Jta3N6Mi9OYUphMmU1WTZ1blczbStVVHExVi9TWDM3?=
 =?utf-8?B?ckZodmJtSnVzWU8xZ2EzeW1HeW83NTQvb2FKT1RkNEE3ZjFpek5IZjdFaGlU?=
 =?utf-8?B?eTl3dklSMzBFT3BQNmptcWQyZTU2cVFROEpOWkpkK2xweUtKallYL01tUlFC?=
 =?utf-8?B?S2xkVzVLMmM2VFFVMEFDc3BSRURYSE5pMkpEYUJhSGRwL0ZrT0pnOU9UeEVi?=
 =?utf-8?B?L1BaL3JHWlZlbDRZZXZEL2RaenZXSXZHRWIrVGQ4YnBiNm9mcUs2Y2t0UEZT?=
 =?utf-8?B?VENXV3hUdVdGeStUOXBXSS93bkQ1eENoTTQ1OXdneUt6MkIzbHpqOGhBc2lr?=
 =?utf-8?B?NVE4OFZvWDgrQWpLQWh1SFo3Mlk3dnQ2MHZTMjV4QjNjcy9QQzRmd0dTN3M3?=
 =?utf-8?B?YitpeWJYb00vOTNKWXNkK1dyM3NKQUJraXl4a1QvQlRsdm44bTF0TEtaNGlS?=
 =?utf-8?B?VlEvM3o0a2RmZGRuODl2QzdSdHlTS3crRnNydE5jcWdDTFE0M0FKc0dvV0R0?=
 =?utf-8?B?ZEVSMFRIOGYwZG9tdVBVaHFWR2pybFpDNFJTVFRsRVEzUUYxRUVpRlpJblFt?=
 =?utf-8?B?MVZKZ254RTArWVpKNEtjMEttUTh3YTIyOElwdVFkRjB3MzN3YnliMTA3VExl?=
 =?utf-8?B?SHlpb2V1R09TUHdUbW00NmFReVY4ZGd5M0g1OUt2MnJCM0I2aU90ZGRBdHZR?=
 =?utf-8?B?SHVyM28vY3JLc2tPMnlKRnVHTFJ0TS9PL0xxRFZBK2ZzR0xoVnozckdva1Yr?=
 =?utf-8?B?UlhNKzQveVk0Z2dGV1l0T3diSGtqTlhHejFrZ3RFM0ZjbzkveDVQRHlkTld5?=
 =?utf-8?B?OVZGNGxuU3ZyanduU0JiSGpSSllvRlRFRTRFZnJPYWdQcFRwazFDQUF3SlUw?=
 =?utf-8?B?TXE4aXFxR21MNlhxSG1QemFJRTE1L3pNUVhyenlaRnpHVGk2clFqT21iSHdP?=
 =?utf-8?B?OGdqR1dtS08vT1ErOC9vL251T1I0cVphWVpPYXVQNm1nTUFXSXE0SStCcFB6?=
 =?utf-8?B?UWVwSzBtK1pwaFd6QTdQY3RhWndjTDR5a3VZM1EvYzB6VFpUUG9IaDE3K0pY?=
 =?utf-8?B?bXZBc0twbDlvYjdzYzlUQXM3N2RZYjNJQWZ4dWg5NHR4WEdOS2sxZjZtVnJh?=
 =?utf-8?B?b2cvSWdFdEVKMDVqOGxUN1h5b0JYYTA0ZmJxK1FHeElRcXNRMER1Nk8yTHRx?=
 =?utf-8?B?YkV2TnlwWGxrTm5VTHd1dUVBMFI1Y0x2RTRGckpGN0lSVjFHUk1lRE5hNkcx?=
 =?utf-8?B?L3FtZXdYOWE3YWc4U2VkS0lZaElod2swUTdBNE1udXRuM3U0ejJIV0ZTWk8z?=
 =?utf-8?B?eC9mbUo0NkhLSlBxdUhIS3ZJbUpOaFF6bVh0N3lyU0ZCd0tBdXl4YlQzRm10?=
 =?utf-8?B?b1BueFpCQ2dBVWhocVM1U0hGWC9kYWpVWmNsbVM5SnZKNTBEd0ZndHd1bVlN?=
 =?utf-8?Q?1PL4Cc2Wsrj5lxYfdrg2ZbJFfCiGCJN1c6KgWWo63yk1i?=
X-MS-Exchange-AntiSpam-MessageData-1: WbdWrizvO4n62w==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e9a8adf-2d2d-49c9-8948-08da5097db84
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5338.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2022 19:30:38.1244 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gyyM/ZZi9b2nFadNyh3mYIsTRJu3R/r1GTXAsi5z9dDiddMUo3DiqEnKCj+rHr66SYZIfYEDQnXS6dmH8c9RrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3156
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
Cc: "Yang, Philip" <Philip.Yang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Reviewed-by: Eric Huang <jinhuieric.huang@amd.com>

On 2022-06-17 15:26, Philip Yang wrote:
> This reverts commit 8b9aa1fa82baf4e8b6a2daa3aa4d69b728df727e.
> As it breaks pqm_set_gws.
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c | 6 ++----
>   1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> index 67ae5b6385a2..e1797657b04c 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> @@ -866,10 +866,8 @@ static int update_queue(struct device_queue_manager *dqm, struct queue *q,
>   	 * dqm->active_queue_count to determine whether a new runlist must be
>   	 * uploaded.
>   	 */
> -	if (q->properties.is_active) {
> -		add_queue = true;
> -		if (!prev_active)
> -			increment_queue_count(dqm, &pdd->qpd, q);
> +	if (q->properties.is_active && !prev_active) {
> +		increment_queue_count(dqm, &pdd->qpd, q);
>   	} else if (!q->properties.is_active && prev_active) {
>   		decrement_queue_count(dqm, &pdd->qpd, q);
>   	} else if (q->gws && !q->properties.is_gws) {

