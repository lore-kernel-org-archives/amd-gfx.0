Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DE23C433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Jan 2022 13:58:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E330010EAD2;
	Tue, 11 Jan 2022 13:58:02 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2074.outbound.protection.outlook.com [40.107.92.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 716A710EAD2
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Jan 2022 13:58:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RVMRO6VTtbHgPYq010YsAteP2IGf+5joOtcAGNwuUpcHLxUA3ivpWpID9GWiu1ezjVTl8XxH+Rp3uPUIsD82FP6ppXhYAkFvnsn9BWFqA38OiV5C7caJ0435MWhD5EzSKesUp4wHU6IqpL6oFBmcmdxAypxXzpeKyC0EMWOxBJqvUciXOPDzR6JNIP5MbWAnVSEF0e0Z49kiSKk/dL8KzBeIyi8JHzhRSAZYKT//NB94IGips2xuQPKSIgYt+yE4bOsy/JDs2eO8rLJXw4OINPCyW4L7/Xddt6mEbYrv3c2/z78XioWwUU0oCZWnpqUNlVO9F1+PKmwbVlgZq+pokw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QVlHMXxOiqVCjSq3qAn5X0QowuuatzBRx1TkDFeeE3M=;
 b=lfgPvkwhGOGIyt2Flg1iYNoOaVGdfGvNdwXAh9KLGunzdOZi7ZPOgBBvzvVCXGfpUwfpPTFrz1aiIQDV5YieSM6hYPWu5dJI35vxid+RNbSfZtIAw0yZWj+v7cLJzPdjYMtvqg2LeE6K8UqW5d6oyIfbzmqme6ukWYDEzyJLgzIE66ormJXZMmqSj4jAq5i7kqhsdzUMyKEtEMA0PXmn9ssVK2fGDklTIgJxVrx2+wnC+FcswYVfwYv3ApjD1ZXqQEypvA0v0SyxNk8IX5rjeFhTkMhW7Yi7MT7scUJYe1lnG/4LAjYEaobaJ8l8WF6JhwoR+7wqfn5N2DZj2YkgbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QVlHMXxOiqVCjSq3qAn5X0QowuuatzBRx1TkDFeeE3M=;
 b=jwjuTtPaE+KgwdQs4iyRy1uzfWAPK6b4mU+ooYoTsRKuH3kdOdtYfq4ukvohQGlpS8yjJlFhJOB4G8C3vlpt0iUYbH3H7Hcx8oDKsFkoJ2vwKcqVtSvVIpCX6AaZGNqLjrNy1Olk4DlQL3O+XS/QTqvvaNMYg/Rr4GtujdzKluM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB2896.namprd12.prod.outlook.com (2603:10b6:208:ab::22)
 by MN2PR12MB3422.namprd12.prod.outlook.com (2603:10b6:208:ce::27)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.11; Tue, 11 Jan
 2022 13:58:00 +0000
Received: from MN2PR12MB2896.namprd12.prod.outlook.com
 ([fe80::44f7:66fe:4419:d8d3]) by MN2PR12MB2896.namprd12.prod.outlook.com
 ([fe80::44f7:66fe:4419:d8d3%7]) with mapi id 15.20.4867.012; Tue, 11 Jan 2022
 13:58:00 +0000
Subject: Re: [PATCH 1/3] drm/amdgpu: fix warning
To: amd-gfx@lists.freedesktop.org
References: <20220110201929.1949571-1-alexander.deucher@amd.com>
From: Rodrigo Siqueira Jordao <rjordrigo@amd.com>
Message-ID: <2ac0f3fe-afc5-1fe5-300d-4d7bbf0a9f80@amd.com>
Date: Tue, 11 Jan 2022 08:57:58 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <20220110201929.1949571-1-alexander.deucher@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0428.namprd03.prod.outlook.com
 (2603:10b6:610:10e::23) To MN2PR12MB2896.namprd12.prod.outlook.com
 (2603:10b6:208:ab::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 55738c33-f9f1-4726-7f49-08d9d50a60f9
X-MS-TrafficTypeDiagnostic: MN2PR12MB3422:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB3422391340422BFD1E7D01B498519@MN2PR12MB3422.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1227;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kAU9r7JX3phWTNIbFO87fH+44jRiQGmEB1hPIxQ5xihCVopV8xHQlbzfVxU6xOt6eTr6YFeXeFUOvd0+pC0p45vOXly6e79yb6YwvksUUw5BkzqYrw5TD1SQZGmokmWJ7QJ9JrEC+s4Qq+S8RTPWxAlY3Tgw/HP8jD14H1m1U4iVYiHaCcVH1emudm4GcPqYYNVsbNeuFHZxzqDJ1Hcmc598NWqPFjUWarvxVJZCC75vEuN9by3Btcb2YDpO9Uv1lFbj8YY7aCJs0ZEhw7XKdPAaaDXQoyURGv16HmKBXSFHJbJGDSJ3WZ7Gt3KwapIdoI86m1swdhPJ2irVBzAhq0iEJCrDrNQCpwxC56MgITbL2hAR6cYQm1bmYvNFkr05QITd5o8O4N5D0ITANaBMa9BP1MXBS3ZfA3itjpOwMKbVpjfMekPyaZ1nng6uTgqVMHXQ4xOdtrGnnSgwyeyX2Ny+djV9Owy458Qg9p1bEOxGi5JR5oMMNRtSkoqEcRbldJ4pOVRKAGoKyLQQb0rrRB1lJ8+gpWzyfJ4fdarfLHBgHlPVH9xWc2NyR9gQRPxrp9s5iAi+vgMo5H3xeT9N/3gkfBnpXhM2iXHmQ8JkKrphtHBvJKdwP2pMAuiMVkW1SlwjLwDVxvVkWo28OFLbFFXEoZiUE0QOrvAiqxdMkQN02sF6NH6vtUCdbwLIanP7KfhBzVfh9OcQvBNqrTxKJZbQ+rkHdiLd+bJIrACPnbcJaSYAScX5SYy1rKAIfAB1
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB2896.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(5660300002)(66476007)(8676002)(66556008)(53546011)(31686004)(38100700002)(66946007)(6486002)(186003)(316002)(2616005)(83380400001)(31696002)(2906002)(6506007)(8936002)(6512007)(6916009)(36756003)(508600001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YUxBeUx1L3RubFlrRUZZNGZMbENwV1Y1ZzJOUG9wU0w1QXh6UGV1TUU3eHVx?=
 =?utf-8?B?UG5MY05vSlJ5TUVtdmRrSWt5d0d0LzdqY3czcFNUdmM1RU1xUGJGUjNMa3lz?=
 =?utf-8?B?TWU1UStmUjdvNHVDaHphbWVyWCtKQ2hrSmhDb1NWZkkwOCt3QmV2aWR3WWkz?=
 =?utf-8?B?KzlxVHduZVNBdytDOGZGWXg2aEZtSXUvKzI5a1Zna200dDBvdFVsaUhld1ZZ?=
 =?utf-8?B?Y2tsODY4K0pLa09CMXAzK1pXa2M5SDROU1g2N3R1aFZBcjQ5K2VCUFcxSlZP?=
 =?utf-8?B?emlSK1ZWSG9RL3JuQ3J6aFRqdDEvTGRzM3lFdWpYNnNZRjh3TnVDNHIxZFBo?=
 =?utf-8?B?bnR6UG1NUzhZTlRwVFZja3l3dG1QZVg5YStnS3J5Q0VIeEhBMk1jRGZFY2ZL?=
 =?utf-8?B?R29mckxvT3VqUkNhbWNLUWY5SVUxbG5NVzU3RnRsbWpqS3RxWXZIa1NEYjlk?=
 =?utf-8?B?OXhsK0U4SmFid1F3SWk3d2J5V0IyUDhCR1paVFQ0K1FHSU9paTdhSDgxWmNt?=
 =?utf-8?B?QklrWDU4ZDM0VWp3V3l2cmR6TW9DVDV5aG9DQ3F5bWhXbXJKQmVpTUtCQWcx?=
 =?utf-8?B?T256VEJvSm1KcUswRXdORFRxaDFlajJQMUV0UThwVEtBWHlBZ2VXU0wrMlpw?=
 =?utf-8?B?NTF5czl0V1pSclpIczdvNzlwOG5oWnpmT09iWWVEWUJvc2I2T2ptY29DTHdt?=
 =?utf-8?B?Qk1BK2srZmMwbUpiSTlnNjdSaFdEM2pzVnQ1NGh1MUtoTWlnaElrMTFrRGZk?=
 =?utf-8?B?L1FJV2lkK1dESnUwSDlvM3EzbEFGak15SE1KcktYZXVoRmk1ZXE4MGNWaTU3?=
 =?utf-8?B?dGFTc1BWMVk1dzFnVy9QRTJvRkE5SzNpS3prYnNSRXlZeWo3cmtGK3BHTmh5?=
 =?utf-8?B?ZmJmUnM0OGlJMzVORm02cHRGdjNBMVVPSG8yWlJjaHEwb1hsREhiMi83ZWs3?=
 =?utf-8?B?VVFYWHlnRnJvOG0zS2xjeTlRNzBiekhRN3NmQWVKVkxoeEFNVDd6Si8xVWNt?=
 =?utf-8?B?RGJLRHZnalZvTW50V1NLWnhVLzJ0M1NZOGxzbkdPdm1LbzVQTWY4RzlYL241?=
 =?utf-8?B?WXExam04RjBldFh4UmxZeGtZWllxYXNqbnpRaVdhdHFDbmpHL2NqcmJuOEVV?=
 =?utf-8?B?MWFpQTVqd2xWTVk2WGJDTGtTYmlNK3lLdTJ0TGtBUnZOeHZiaEtDZkFRN09K?=
 =?utf-8?B?OTkwa3VoRGk4WUd2Nm5iWkpGcWlZQnJ6T0NUV0lvYldubDMzcE9mOE9zc3R6?=
 =?utf-8?B?RkJoNnZCWGJBMUdreC9BdkxyTkZoL00wbWVsOURvVi85Wmc1Q0pXdTVPdWtn?=
 =?utf-8?B?VlVjb1orc0NmRzJ0cFhNRTMzRmFLYzllZmQ3cmJsYTM5N0M2dWpncHVJakVh?=
 =?utf-8?B?dHZGY2w5UjMzcnZTcG0yM0ZJZTdHMmlrTFpsbFNzUW5UMlRIb0xYbjZGOVZF?=
 =?utf-8?B?dXlqNVMyemduRUVJcDA2aVBoNFB4NVVnbE1uZ2VkUE9VQ2NqaFh3QWMrZEVZ?=
 =?utf-8?B?MmpWN3JnSXNCTkM2NzVqNGNsOG8yRUwzeWVuWmxVMG0vTUZVRGVZekt4VzFx?=
 =?utf-8?B?WmJZWDRpa21ZSmg3c2Q2dmZZQklodm5wcmlwNXBnSzd5YzRZcDd2c2lqc0Qr?=
 =?utf-8?B?NHpyeGZjQTJ4ckp6TDMzazFNenRUVTBvUUN2UTFydnI0QldzeXowMlVSOUpB?=
 =?utf-8?B?cVJNRGIrNXJ6V0ZVQjZiaFRpU3Z6bkRmcUZuUko4MU1oOENEVVF2MnBwb3Z2?=
 =?utf-8?B?UnUvRnhjZTJkbjhXeUgwUVEwaHRSTnphbzBFZEExNGhId0JGNnU3SGJ1MCtn?=
 =?utf-8?B?L2p5M0NOYzhOazJEdlRBeVlMNXovejI5ZTNaUkY5UUtzYitibjF6VjF6T1Iv?=
 =?utf-8?B?S0ZQWkhHbDVBLzE1KzNZdEN3T3NLS2F4bGV5T2xOSVczY24ycGY4SWpQMzBs?=
 =?utf-8?B?OUhVTDdDNVc1d2k3Skc5ZXZzcGI2WkxhdXU5bTAyQlVaOEMxb2dQcy9ZMk5S?=
 =?utf-8?B?RzVLUVBvenBaRkhTend6Smh3bThxRGJVRzY5L0p2Z0ZLS24wQ2FjWTYrODdo?=
 =?utf-8?B?ZGZEL3RGbkVsVUh2dUtUaElWK2c0RWNibGlnWURtZTRJSW5JcWxMOXVFTnY3?=
 =?utf-8?B?dVBaaWRCV1NWeDFUcWMyMWJzYkVUekZpalB3Z1A1WElsRHltU1NIUitCcFF6?=
 =?utf-8?B?bEg3US9KWkZGWkhCZGRWeXhzcHc2NForN2g0Ky9hZ1J0dTdOS1hGSTlVejZH?=
 =?utf-8?Q?vwCt3vurY75gMS2CAgYJmKEpdIOW/jAa7WORkXUJ0o=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55738c33-f9f1-4726-7f49-08d9d50a60f9
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB2896.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2022 13:58:00.4148 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qUjiYMuvuI+viOWslPs5dqfUop2WKUInyYMNkb6DbP4SbmwXluSQJ0B/E9fIoHuOZBj2beLkzDgF/CA2vnVpvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3422
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



On 2022-01-10 3:19 p.m., Alex Deucher wrote:
> warning: ISO C90 forbids mixed declarations and code [-Wdeclaration-after-statement]
> 
> Fixes: 8c50db2f64ee ("drm/amdgpu: Adjust error inject function code style in amdgpu_ras.c")
> Cc: yipechai <YiPeng.Chai@amd.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
> index aa8d614009d4..478457637d29 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
> @@ -949,7 +949,7 @@ static void amdgpu_xgmi_query_ras_error_count(struct amdgpu_device *adev,
>   /* Trigger XGMI/WAFL error */
>   static int amdgpu_ras_error_inject_xgmi(struct amdgpu_device *adev,  void *inject_if)
>   {
> -	int ret = 0;;
> +	int ret = 0;
>   	struct ta_ras_trigger_error_input *block_info =  (struct ta_ras_trigger_error_input *)inject_if;
>   
>   	if (amdgpu_dpm_set_df_cstate(adev, DF_CSTATE_DISALLOW))
> 

Hi Alex,

This entire series is:

Tested-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>

Thanks.
