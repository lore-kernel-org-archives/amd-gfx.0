Return-Path: <SRS0=770C=P7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14B97C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Nov 2021 22:24:17 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E22C60F39
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Nov 2021 22:24:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9E22C60F39
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3348B6E037;
	Fri, 12 Nov 2021 22:24:16 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2062.outbound.protection.outlook.com [40.107.96.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A3C906E037
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Nov 2021 22:24:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EAwaJjAHBWmmSmHM2Tj+HHk/n5Qg4R/IPTEDgm4aTQflzpMVwQ/nKjlpbPejB1FE9M/4GoZdspFwdlKq0hGnTFskXDuoYBCY4N0ajB446Ho/57LZY3gRuVXCBuvp8lq/zDs/7R+jPnzkhCcQFLc9Lgei+K8AXhzDLDbdx+vJSwpeb4v3j1O+N8RpLKj6RxDflIdGNl+ayGgVZISq/eSrydpQAKC6p9BLWetl5/A5JqbsahZ5prJKKP78g8rLnQAuSY3wQxCyN9tIi3OlR+30jlyHM+sqyD4CJyDUHKfsf6+7HQPpDxnINBjwoOUPie7C/BqW7CMkfX8dys+nmOzS9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=luOFObKv0AVfDeSVFJR9J06mJKNHwPyf+gxfJ1y4l/E=;
 b=NVG+I2JTAUnipMGdCiUHmBVlIQWG/oTNPt1ISC3UsRgCLle+nWXBNaGYxXX/wGn/CVBmLbYQwZGr4bZnqMVDDOzF3a5cjW5qhwJyDIVJMaFQz/oHkSTVb7QvYOu6FXpaTjjVgfqLQqiqbcRZLEF6V0T+2eCK1wDsosjK57E5ouSdlmIgPsJ0mXrz0Nc4g7HGOMHd8WESz0KN+dPFpq+VOkpFgWNIv35vYIXqNJWzuaGxr3j6ko40rzz450+3jcdCPf9AgDs4woNDcFJ+yI4znJKlL8Mb0sl/lQnsRxp6sS+15e2PdZL5JmG9wlZxCvMjI7v7PNG1NlnP5qUWEMtM9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=luOFObKv0AVfDeSVFJR9J06mJKNHwPyf+gxfJ1y4l/E=;
 b=xAQFlA0zTUrPS56cVNjt4apRIgqCfOkStyVY9ILnh+W/xvBRdM64FM+VuDwrLv10xspRIy/ZNcUN02b7KOfrB6rhhUetTBQzhSv9nN1/RqgtiUD7/EU4qcOqCHZICBTOJAXxsClxSuYFjEcJVlpAiKHgIj2Sh2JVXPti2HqFwfE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3962.namprd12.prod.outlook.com (2603:10b6:5:1ce::21)
 by DM6PR12MB4960.namprd12.prod.outlook.com (2603:10b6:5:1bc::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.19; Fri, 12 Nov
 2021 22:24:11 +0000
Received: from DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::7d09:bfe9:7aa9:6011]) by DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::7d09:bfe9:7aa9:6011%5]) with mapi id 15.20.4690.026; Fri, 12 Nov 2021
 22:24:11 +0000
Message-ID: <a2714074-0e15-ccb0-18f8-5b9a127612cb@amd.com>
Date: Fri, 12 Nov 2021 17:24:09 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.0.1
Subject: Re: [PATCH] drm/amdgpu: always reset the asic in suspend (v2)
Content-Language: en-CA
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20211112162530.149709-1-alexander.deucher@amd.com>
From: Luben Tuikov <luben.tuikov@amd.com>
In-Reply-To: <20211112162530.149709-1-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YTXPR0101CA0025.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::38) To DM6PR12MB3962.namprd12.prod.outlook.com
 (2603:10b6:5:1ce::21)
MIME-Version: 1.0
Received: from [192.168.1.14] (135.23.225.238) by
 YTXPR0101CA0025.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00::38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4669.16 via Frontend Transport; Fri, 12 Nov 2021 22:24:11 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7caac5c2-b06f-4217-cee9-08d9a62b26c9
X-MS-TrafficTypeDiagnostic: DM6PR12MB4960:
X-Microsoft-Antispam-PRVS: <DM6PR12MB4960F1F2C05AE25ABB77DE9499959@DM6PR12MB4960.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kFpYmGtCwLBTw6lDgC7nHVq/QymwKq8rx6Ihhfj1VO9FL6xBjhtGCidNUWxuDPq5RRmntIPqxVJSsT6l6EwRnuZ1B5QJsDRZvdOLXJq4pqyh0WOafMXPaWctMwNgodY5ZVcb34Ldd6MElGaY7tOPgXpCbb+OvPsQoZUo4jlsLTcAGxdtm9wkfE3jkkhRowKOwfJ/Dg/0RBYFz2yTnDGbpdx73gd8eyegEhPyLJEQYJPVsnZ4RpaJpUZqVaxEbkR0DXuSJ25qNlcTrQ8WrXBykCyEfSX7BFazyS4bXNO+XMzzsNzlGG1zjLL8t0FwMiUZ7HJqbdwTlzO91Ui4qxVrFlmK12gBa5bTIMVrY2/E3xFe0xz711yHlcXFVi1KCzf8b9BZJV2J6O+/3MGSk/NMr3PfKxLaqOR8Y57rQwomOicXaSp2b5mmGG4HcZbRdX0uEbZII9M4+ZetomiQ2VkkmRpKO5iwpSzV2SKSvIpGS5O9bSmVWPUta1SbwDBa4TTxCHhnsmGydU6kgDg0CFqi31C3pfXTw1ms3BGW1/LUqwqmKE3GCfjdlUhR1n+OSP/gGN7N7VVOBvWaPE4fXvCsYNARlJvYyDwnXCi69DR3kqGzkKTFIcgra2Yt9DkaMaDkFbTgHUuvA98DWu7U7pVG7Hocjh301rnIdvuFG4V2onpwf6/vnOE0mNggypAW0mtH768vE8DxUMuENuovVqa8NcPPoczjB/Xxd4kXGb0sjgYc2kaktY8XD4qiYr/vp5pg
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3962.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(8676002)(508600001)(36756003)(186003)(316002)(8936002)(15650500001)(4001150100001)(38100700002)(86362001)(66946007)(66556008)(16576012)(83380400001)(31686004)(26005)(66476007)(53546011)(44832011)(31696002)(6486002)(5660300002)(2616005)(956004)(2906002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T1VqVlNFMG1kcURXWEsxOUtVZTBpcmdjcXVBQktSNkVvZkJtWHE5WXZacGsr?=
 =?utf-8?B?ZGlJM3g3L2FmUjhBcm5NOXBmdVdJQVE2aHBoaVYwN3ZMUmdVZnVDZVZ5eW5k?=
 =?utf-8?B?YzZFdzZpVW1EL1kvNUtYWTIvZVl0VUQ0OEVEQmRob1ZpWFpYVzdTNy9qbXhh?=
 =?utf-8?B?Z2VIVEZDTTdNSjVaZ1FGNWRRQ0ZPak1jTjJDVmFuMEpyTkduejhOVkM3Vmdm?=
 =?utf-8?B?aTNRdEhydWUzR2NWUWVIMUZWaEpScEczNDBJaU1DQzdBSS9EdllnTkN3YXM3?=
 =?utf-8?B?blVnWWMwNjlta1JVeDUwc0kxNnVZVExRUTd2d3BlREYzcnZlemJ6Um5CZExK?=
 =?utf-8?B?ZXRkRmhQNVRueXZibjlIamNSNHVWY0EzV0hNTTNkTEk1clVXdkFyWlNLMmpx?=
 =?utf-8?B?N2ZjUkl6SkdJQXZUY3kwOHIxUkFWNkc0WW9BSXFrNFR3dkRuM2trR1FVNlJz?=
 =?utf-8?B?Qkl4eVhTTjJvM1BnUEVNZlc0OEw1emowamZBb0J3YXUwQmlJSTNOUEJ6bDlW?=
 =?utf-8?B?K1UxVS84UXFQSjF3MGIrSmdXU2xoRGdOKytOZEpsVGJVenEzbVkrUXYyTC91?=
 =?utf-8?B?ZlErb3RWR2pzdkVGUWo3S281TUJjZWY5QzBrR0dUaWxOdndoTnI4Vjh2V1NL?=
 =?utf-8?B?cXpHRkx0SGdKNXR0RkJ0cFVlZ1czczhlbmdqMmVta2dPYXdTU1JsTjRYODYz?=
 =?utf-8?B?NjVDTFNHanVXV0FCWlNmUlI4VHpHeWc3OEZZMy9IZ0M3RmV0aFIrdUdUVDVr?=
 =?utf-8?B?azFOcnZ5cUVPOFFqVDBwTlJJNHZyeEhEcVVqNmVRMW05ZkZ0VFFydkF1TmZ2?=
 =?utf-8?B?V28yMGJ2K0Y0ZklQQXkvWkQyVmRzQlh4K0JOSUhOMVVMSEMzRWJEMGFsRFRG?=
 =?utf-8?B?VGhMM2p5enRlRlBWUXREN3Y4VEM5R1kyOFVPbGlrbFhBQWgrbDFURVh1VjFB?=
 =?utf-8?B?N2ozMllodkIzQm16WEtldjZlT0JlUllwZlJhNmlMQlNyL0JyeERQYkNab0Va?=
 =?utf-8?B?elQvS2ZMZDhSQzZJZ2ZEV1FYRzBLSkFxa3c5YnBRU1EwZlQ1UDhDaGJOY2dq?=
 =?utf-8?B?cFAxM0RjcWl0eVdEeGhqRktNQWloRFV3Rm54VVNOSWpjRmhSdlN3OGFvQitY?=
 =?utf-8?B?M3p1SUFPN0MwajJOYU9TRTUxWHUxeWR3NSttSGRtWWdxWUxOUkk2bC9PTklT?=
 =?utf-8?B?aktGUFhKZDlHTU95N3JiQVR5WDVIcklPc0RSZlcycEtwWkRPWlU0MEZJUE0y?=
 =?utf-8?B?a1lWbTMzWnhnOTVuclVFNXRHWWZLTjIwajR6L0l2dVdhTVRxL3ZXWi8xc3Qr?=
 =?utf-8?B?VExiTDdvaTFydWxBaHZSUHptYlgwcGlnK0I1OWZVVEZGQzdQZkY5TWxQdjJN?=
 =?utf-8?B?SllRNGhWelBMQmNQYm4zRFFCVmIzcEg2TGt2cWs4b2Jqa0FDV2xROVdPOU9H?=
 =?utf-8?B?Vnp3eVBMbHpGeW9tTHdXZ2U3TUEvRHFmaVNZc3JwTWlyVjFjYmpzU2tCVFQv?=
 =?utf-8?B?UmtreWt6cnhXV3JlNXdWUkcyUjc4VEF5S3l5OGFGSm04d1V4K0NOZ1VpYWhm?=
 =?utf-8?B?cTZoNUY2K2dLL3JUcTM4a2pzcTZWZndnT2xIQmRkY1EwUjVuVURlM1NEcE9O?=
 =?utf-8?B?WkdFd3NRMmFXbmNwZzNBNkU2ZHhCVm5xanV1T2g0TXNIN1FTYXp0b1htQmNq?=
 =?utf-8?B?QkNqeldkN3ZGd1hBY0lJUmRremQ3dHNWNTZPY3g0dnBkLzIxTmtvL0RjQkFN?=
 =?utf-8?B?cHRPMHdyNkNQTlBISHpnNmtwbG5OTEh0Ty9ENGNyRXV3M1N2cjlnMWkxT1Iz?=
 =?utf-8?B?ZytsZkJPdWJaSXovd081YVlyWkc2OEVhWk82MG9HOWFxZW1XNEVuQWZZaUh2?=
 =?utf-8?B?SmgyNkp0RHFlSHIwcWZ2Smtmb01PQVQ0RUdEbzJjWThrakdYdmd1NlpqR3pl?=
 =?utf-8?B?bjNienFBcmpWTEJ1aURaWkhXdnFGY3A0RDRJQXFSeTR5RnVNUUNrWERDUnh3?=
 =?utf-8?B?Qm5qNWExNmo0aFc2dkk5YWMraG9jdERXZFRKQTZFUE9SZVZDYTFjNmJ4YWhF?=
 =?utf-8?B?Z2NCaUNPbTV0dTNYSUdydHM5dWNOVFkvSmlmODFqVjdkeFpBM1h1VStQUThu?=
 =?utf-8?Q?ngTI=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7caac5c2-b06f-4217-cee9-08d9a62b26c9
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3962.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2021 22:24:11.6429 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XUJj+FGLGTpBQ0GBrKPAgCTjyr97zvCOBQX3ShmBC3VcrBuduuUCHaPVXP/OMItB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4960
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


Acked-by: Luben Tuikov <luben.tuikov@amd.com>


On 2021-11-12 11:25, Alex Deucher wrote:
> If the platform suspend happens to fail and the power rail
> is not turned off, the GPU will be in an unknown state on
> resume, so reset the asic so that it will be in a known
> good state on resume even if the platform suspend failed.
>
> v2: handle s0ix
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index 1db76429a673..b4591f6e82dd 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -2165,7 +2165,10 @@ static int amdgpu_pmops_suspend(struct device *dev)
>  	adev->in_s3 = true;
>  	r = amdgpu_device_suspend(drm_dev, true);
>  	adev->in_s3 = false;
> -
> +	if (r)
> +		return r;
> +	if (!adev->in_s0ix)
> +		r = amdgpu_asic_reset(adev);
>  	return r;
>  }
>  

