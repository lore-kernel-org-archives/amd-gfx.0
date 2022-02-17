Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2F8CC433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Feb 2022 16:18:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2C08410E418;
	Thu, 17 Feb 2022 16:18:28 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2057.outbound.protection.outlook.com [40.107.101.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8BAED10E418
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Feb 2022 16:18:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WG0ecNKSg7BxPtbmilzU9Q78yXdFRFUHXTQ9aGaYXgd3srO7cTcpfsk/8Ps5gdO/WRguQgrrPkCg0OAuzPCQWpkghBcEvjtN90ntc89ZLSldoOMKwQvYoKb8cpDarFzBt7p8ClX4Hhk9wM8XM2Rd4Yl0bPvmYR3PafJxeImH9NX32ErxW6PTKKJhfiLWRzAAJEvb2VlgV1pHNdCOmzXQY3oZBxtxF+FdE/wcYpVtESS2wVtYKe0CUdNjkQ0P+/R6LPXtLLzbOp2aWCzhuFD+Fshls1GRXkDKUabqi8FZ2rdPC1mKbnX+Qam1l193Tnbqd1O7I0CjF5CfYcseqtvz2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uusQqQq5dCp5JFb2PFqecY3gjdl7fjDzWfMc91zENBs=;
 b=KF6CBcwJ6YRKgi8yNDvaTWr7VKqlnCjFx+J44ffJmo/FU+7Nskd/zkG0UNXZcSsPfDytM5ZaOAa9jpASbAtl1w8chXhRTtFHe9QeKRFQrwm1c2IFZlvcn/jHkczdZgnmY/3MAtnAH8SU2Bw6RlLlfHirq/OkYXyzy/DaKzVtipdjcox/xEFwwFCykWCFF7eM5HB9+AxevNhlkfGMYOGsfFHXKBT+mrVx/z9K8UYdi8WbdXVZW0qu0QInwgfAO2pyxE+nWfRYWvETE/ZDajS35Ly6IbjJWuvcTd2TyjfrebRwN1TYvQ7e/ZMwjFg7Lvtx6fOcDNVoxdKFSUs0a+bLSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uusQqQq5dCp5JFb2PFqecY3gjdl7fjDzWfMc91zENBs=;
 b=Uh4EzME+7R9tZOkUt07t9nZx5NdMdKNSYyQHBp5kRBsz5RNIXO9LZtJku8NB4SAtvHwiiOQXWPFH1lg3Y3nxg07X+TtUulMuDCjSV/6d5PIVgZuo3eZoc9DlBq7P0dIsGS3iyGDtBs70Rb6Un+0VNyq77Ra0879c8IWPWqS7/D8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5157.namprd12.prod.outlook.com (2603:10b6:208:308::15)
 by DM6PR12MB4564.namprd12.prod.outlook.com (2603:10b6:5:2a9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.14; Thu, 17 Feb
 2022 16:18:26 +0000
Received: from BL1PR12MB5157.namprd12.prod.outlook.com
 ([fe80::692d:9532:906b:2b08]) by BL1PR12MB5157.namprd12.prod.outlook.com
 ([fe80::692d:9532:906b:2b08%4]) with mapi id 15.20.4995.014; Thu, 17 Feb 2022
 16:18:26 +0000
Message-ID: <809e60e9-2c02-4219-6db8-9207fb5484c8@amd.com>
Date: Thu, 17 Feb 2022 10:18:24 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: drm/amdgpu: do not enable asic reset for raven2
Content-Language: en-US
To: Chen Gong <curry.gong@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220217090702.1573034-1-curry.gong@amd.com>
From: "Limonciello, Mario" <mario.limonciello@amd.com>
In-Reply-To: <20220217090702.1573034-1-curry.gong@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR12CA0033.namprd12.prod.outlook.com
 (2603:10b6:208:a8::46) To BL1PR12MB5157.namprd12.prod.outlook.com
 (2603:10b6:208:308::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 93ffac78-364f-44d8-d416-08d9f2312049
X-MS-TrafficTypeDiagnostic: DM6PR12MB4564:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB4564682A8EE2B8A98730F6F3E2369@DM6PR12MB4564.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tqT6R2aEPau75VxfEHXn4KXqL13924sQu8HDR2UjAP9Aw+khq4PbIpRwkozQ69VIgmwrVdlmt5lwNGdm7/8YW8B+t8IpQRum7CJlNVNHqBeFpPPhyuh0VDGEaHzLatR6e3idDB/gZ1dxRmpB1BmO3CEq7nqRFOB9CaOjeamw4IjzSY6HPd2Bm66svkBrdi8ZE5SqWxoSn7FBLASmX3cfjSNQHXRd6dw6HRXaVrWa5QPBTZIbczorcUVJtX0c7UTiqbpRvAhZ92DRJkScA3Z6rrmf666NbLRV0V31pTeRs4LigLHBORfQDTze2fFAIyiS7EEZQNmM/N4i7u9zlc/6irHZo3J0lCpd1JocakdhpWDL8/m7eyRYzrbHdWF+//2FqHaBQQGq9bdCyrTp5YmeKFyfIZQL7A+SAgdCQwDC8Hvh/vFO6L1p1nGI5t+jgaBGSNTl4ZwYcp/hccaKwxPBDzYLXUB171zQHxOCFToGAF+HrD2G83VPu1qO21sZce7YNL8SzJ3iFG45WZbyABBGhlqVjAef5NsztOfo63BT5eSasKA4k6vZZxoZSV+gJMvnnZgdCX77xUm9HuWvXH86Ro+7ZNbp2FKe1OE2izw0xcRP08oYAxWp+8pne3xMsehffmvJ1r6E1gpUTKLMsXGTinQCX0aBc/bwm7UR5XQqL3maqZdBfaeVlF3oIVVWrgPhkWwPJYBhQI7PL6cQPU9F03AwYfDOON4Y1hJZBr85pdI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5157.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(6512007)(6486002)(508600001)(36756003)(31686004)(2906002)(53546011)(6506007)(86362001)(316002)(8936002)(83380400001)(5660300002)(38100700002)(186003)(2616005)(26005)(31696002)(66476007)(66946007)(66556008)(8676002)(4326008)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S016aWdQVUNYUThQdEJWaUZtdFdESW43U2k2cm9Fa0Y1MnBxY2lVZHpNOXlT?=
 =?utf-8?B?WFZxdWF4b0VWY2p6dEo5QjVHZ2ZvRFJJREhIUlo2eXFacm9IV1ZkS21kNkJi?=
 =?utf-8?B?UGVSdGNpWVZFL0M1TUJuVStmSDJSbnVaRUtTanVGVjREdXZ5a1RNdERGeFVO?=
 =?utf-8?B?NE5XMktQMkhiWjBhSWJHMkFOcHZQT3pwT0F1TjRMYUlZRk05QThJeXJPWEpy?=
 =?utf-8?B?TkRCM2daaTBPckpSdkdFdWJzTHB0S3Z2aEwzT1M0QjdwNTIrTDZGTjd6QUtE?=
 =?utf-8?B?Zzk2Vyt5WkZRbUI0bG9kakJhREZFUWxyQjVQTUc4STJYdEo4TFJoRndCa3FH?=
 =?utf-8?B?WTVub0RJenpWWmVVVG5rTVFsNzk3aVJmaWZLdzZDdnFGNjhiWGxuem91VC9v?=
 =?utf-8?B?ZGpycTV0VlhhRm1jSVh0YnZ5bGpRUlU4REpKeXFRV21tYjhFbU9Wd0xMN3la?=
 =?utf-8?B?Z1Uyd25pN1ZscG5jM2V4TTF3SEs1dzB3eUFHa2pHVU1NUERGdVB5MWlUb3JP?=
 =?utf-8?B?T0FNUjFORzg5VzkycUpJaHBwY2RFd2VQMFpwQTQwK3BkRlZ6TytibHV5Slp2?=
 =?utf-8?B?eURQWE5VQ0lXWmN4V2RYMHphZjVnL0FOWEFxOUV1T3hPSGtUb3luWFF5UHJx?=
 =?utf-8?B?UCtVakpES01VN1k0UDFiZC9nU2QxRU1sRzU5ZzZxWFBHUWw5WUpDeVcyalV2?=
 =?utf-8?B?OEYwbFVBMk9mYlQ0QXhYdFJHMkh0bXhiSUw1L3lNa3NhVlZKWjM0U3pVZVBV?=
 =?utf-8?B?RVp6Q0FUeFluYnIzdEdUcjJEVmYwSm5RanQzM1U2THp0a2hmRVJVTENua3JL?=
 =?utf-8?B?eFJUYU5sV2Y4TDFmOE8zdEkxY29vaGVCaXJvWTZTTUxFQ25sQWlBSEF3TFRN?=
 =?utf-8?B?QlhxNWNKcWd2MGVGSGltSUY1TDJhY1JLNGlMdzVEYjRZL3NWTWM4akMvZFpT?=
 =?utf-8?B?OTRiajhxTStlR2t2M25jdndtT3VoMmdCdlJmcnZjVXpiem42eVJFUFV6OXRU?=
 =?utf-8?B?L09mZFlxSHU2N0o1NVNYaG9kZ0RON1JWUW9VNmlYWTlIVmF3Uzl0Zko4R1NH?=
 =?utf-8?B?czBjMVpxWFpYa1lOcWhWbTZqVnJBNWR1TDYzQTNuU1B5ZkVwd2MyUURHQzZT?=
 =?utf-8?B?NDVnbktVZm4yVjVNaXBHRXVjRk9ZWFFTWm05Vzd5MnhYN3RFNjJMUzBXVk8y?=
 =?utf-8?B?NGVCYlV1bEY4WmhyV3VNSWJsUHc1M3N0LzBkejh5dWhoOUNTVXQ2M0NPS2Fl?=
 =?utf-8?B?cDk2ZkpVb0xJL2x5ZmdacnlYOGFCcmVUMlB2ODdObkJtS3hjdlZNbFU5S0Y1?=
 =?utf-8?B?VUU4MWh1SXFCRzNRTkkraExoeDg4eXdoVTBWSVpXdVJLUUxXU0Fla1pOR21V?=
 =?utf-8?B?SkJ4TjlxSnBjMXYvVHQwNFdCelhxYVpuTEJUUkx3UEk0WG5kSlpHeDFpaWUv?=
 =?utf-8?B?Q0pDRml2RWg1RWJTR2NqY2tmOTAwOE8wMG1WbDNWaEFCSkNWbit1U3ROeUpI?=
 =?utf-8?B?aG1qWmZqWWFCcHdxVXNDeW4xTTUxWjJRTmoxbVZMUVBab2YzVDVsWEdjM1I1?=
 =?utf-8?B?QnYwWTliZU44bjJlYnlXOTU0OEZCRmNHSzR4SzdFeTlIZHVIZEpGMUdpV0pT?=
 =?utf-8?B?ZTAvNXlYcEFqNERRSnlaZFhiUzgrVW9LdnZWYWFSa0ZVMHlTZUFsak5ydDJK?=
 =?utf-8?B?NjVaeUhsZkh0SGJydlU2R1pKb3FTUzh3UWlKMllkZFNsNWluOXFBYlhGcTFZ?=
 =?utf-8?B?d3lid3hFQkZReFdNTk5uWXBSazlGcHdqZy9QT0w3T285dTVBamIveENwcmJa?=
 =?utf-8?B?TDdtUzUxLzJXNEtxMHQzV3l6elI1UE9PcG55amcva2o2V253bmdlRk9EdWJv?=
 =?utf-8?B?TXZzQ2l5R1NLUk9GZXNMOEhITnhwdEI1UnJvSisxSVNkZUp3MFIveCt2YkU1?=
 =?utf-8?B?Y2xKR1EyNDhxdXZFZGxNK2V3T0FTdVp2QWhtL3RzR0hGZUk4ZEVBYkw0ZUtu?=
 =?utf-8?B?ejBTajFmaDExZWVQYldlc3puYytiVXRqYThSR3NMNENTN3prOEY1SDNBR3hz?=
 =?utf-8?B?T21NZm8wMXFVLzhUZExrSjdZYUlhTGNOaS83LzRRdHZmcjNyS00zb29kekNk?=
 =?utf-8?B?Nmkra2pRZUVrMk5vam45UWlhdHhHVlBXVWZaZEdlTmFNbStGckJpMGVRTWpC?=
 =?utf-8?Q?uPhKaX+AfNqKxpvvSge/wYQ=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93ffac78-364f-44d8-d416-08d9f2312049
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5157.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2022 16:18:26.1164 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xiAjKFd0otAu4+3dfV2J2SqejVvCkHjtZ7+eBpwmZzmsgPp+zzYxRHTtgurWUfA9Ar3NH8wlPqfTI/uvSjY8Gw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4564
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

On 2/17/2022 03:07, Chen Gong wrote:
> The GPU reset function of raven2 is not maintained or tested, so it should be
> very unstable.
> 
> Now the amdgpu_asic_reset function is added to amdgpu_pmops_suspend, which
> causes the S3 test of raven2 to fail, so the asic_reset of raven2 is ignored
> here.
> 
> Signed-off-by: Chen Gong <curry.gong@amd.com>
I think you want a:

Fixes: 6dc8265f9803 ("drm/amdgpu: always reset the asic in suspend (v2)")

With that:
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/soc15.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
> index 25e1ee2bd2f7..4c6775ff7619 100644
> --- a/drivers/gpu/drm/amd/amdgpu/soc15.c
> +++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
> @@ -586,8 +586,8 @@ soc15_asic_reset_method(struct amdgpu_device *adev)
>   static int soc15_asic_reset(struct amdgpu_device *adev)
>   {
>   	/* original raven doesn't have full asic reset */
> -	if ((adev->apu_flags & AMD_APU_IS_RAVEN) &&
> -	    !(adev->apu_flags & AMD_APU_IS_RAVEN2))
> +	if ((adev->apu_flags & AMD_APU_IS_RAVEN) ||
> +	    (adev->apu_flags & AMD_APU_IS_RAVEN2))
>   		return 0;
>   
>   	switch (soc15_asic_reset_method(adev)) {

