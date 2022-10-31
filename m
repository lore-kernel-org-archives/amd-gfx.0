Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04B40FA3741
	for <amd-gfx@archiver.kernel.org>; Mon, 31 Oct 2022 19:22:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A08610E130;
	Mon, 31 Oct 2022 19:22:57 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2067.outbound.protection.outlook.com [40.107.243.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5002F10E133
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Oct 2022 19:22:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m0ZIberM5w/9mg3/C9Zy4HIo/kU2AsM7wUN+HBpI4j/R2hO0xzh9bvSQ2Qg1msTdlpp7tyzvQmB/a/YwWbxbLhAgVT6Fq5QMk16lH69XucbqfHMN473+NlYAgr7RsjEGyHBq4Dsnm1oO7zcJ5LL585y57gZcfG/Zkj14fbKnbBvxunIAqGU5tgVyLRuSzv9x5A9AZOelJq2ZPUTz0O3TSN6XDr97lcJS4EQqVYLbSy0Te5Ml+qlDYsSSwWCbkqVio4l2SZ3sOfDKzaZ/9tVYURA3I0Tf3TUJZacXfra8f841fdVvtmd9+JLn33CNX9a8WTlzwAMWV/nmkGIGmUqPFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hoSgbEnv9nic9vaE/fAXLLg5V9wqxEZ8xJo5f10ApKA=;
 b=XoLpS5QKiZuKW0zQM/wYO24zzerepsYkutZrqKBlQxoJMeYcez6Zl8bV7X4T8jjldLG0nLAln3MSiUU0XPmSBNkOihPRmrbLJvClMaaHttpTJq94V4dz7pkiideOY/2YTXW0pej/tHra7fXczBBXg66Wfyl7qgaG64CFKzU9pxHRsvXjd0IVe2P8dxFZhXkkZfP6/mGZPPEFPuRtUaFpv+2fkTSaE6OFEYphRkJv8t5kApgr3FgnxHW5SKMwQXhy+KZLJWoBegfX3ekPB2CUve6dU2rZpFVlr7sTIUR5WlbOeaJfRCa9fCJK6F9OrDLBFMcMgSmYub0cZN/PlcktlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hoSgbEnv9nic9vaE/fAXLLg5V9wqxEZ8xJo5f10ApKA=;
 b=PvJzoZHrpjBr1ZLLHrp0mTewyHGuy/aWuFyga016prAm4D4P+0gpLwS57igFBpyiTHa8CR+2yA9aKKocTVp13NMrILi+jPm2vvI1WLRc0vxOoW0hboQx7gt7bZ0QtUpk8SkCnO9awoPCN0Sq/2Xo5LCboVJPZTGOKLl7PaEun+s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by DS7PR12MB6238.namprd12.prod.outlook.com (2603:10b6:8:96::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.28; Mon, 31 Oct
 2022 19:22:49 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::2969:1cb0:4e83:5de1]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::2969:1cb0:4e83:5de1%7]) with mapi id 15.20.5769.019; Mon, 31 Oct 2022
 19:22:49 +0000
Message-ID: <ed26009e-17ca-4d2b-41e2-874a57d7cb69@amd.com>
Date: Mon, 31 Oct 2022 15:22:46 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH] drm/amdgpu: extend halt_if_hws_hang to MES
Content-Language: en-US
To: Graham Sider <Graham.Sider@amd.com>, amd-gfx@lists.freedesktop.org
References: <20221025134222.510152-1-Graham.Sider@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20221025134222.510152-1-Graham.Sider@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0013.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00::26) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|DS7PR12MB6238:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d7606d1-42a2-4623-41e5-08dabb754c07
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MFEaHeIlF870OepkPI/tqtriPKY8VWNjOXdtGYge3sSNFP1OpvM3Suvs8+oy4GAEvKYxSIvLZZPaWX16V/ESg4ZXEXpqSMiV9e9Jg0mrQY5KHQae76z1tPa8P9St0TELb9l6D2Jj3yBe/S3w0EbRwWVxDojmi8EZDtTr1i24L+I7yJI80NgP5YtPgD8RNB3JKbuEtpxTRCtaqPHHB5WSrNLjwNo+xBWmDrEIQT1pUr0ajDkJOndb+stys/mlZm9w0Z2nO5smNBrPbZEWT9Z7W4CMsoSriY/pi771+bIYipCMCC1oiDph1IFNCT5jw/1r558teFyaU12SBWkoDy0Hx53b90lQWy8zq2EIksyE5pFRSrOL0RrkIoOaLGgBjxCG+byVbWhEzwIzF3/9e5B2kI7EkGkGU6vEpFWt/eX4omitHhiomGq0X+AzJUWGYSKoCiiFZAmZDAAJB1lJcJ14le4eqG3aC2DPcUtRkIzGtK58cOlfXbYa3o0UiskwafL299PQ7k5ibMDnp6kH1hhNzdxl2qsunzwTLMfQT7SivDYPwIODDQBvtNoFX4A+LryJudxU8/ku1rnTLyXiFx1B/BxHArbOOQ+HBqKnCS4aQzw+z4UdylTa2zq+XLemOhNsRsHMY6ELm9AJpkg2GeRhUSCW6eb4+ewp7QRhMX3c2eehCbNrJFQ4MahKgXEXkimH6aTpR3srL2EduXj3xcKG1EIyluitdhcyo5Y+5FMQlHZ3v9vkXgBuwUB/OX4FbwBz0J3ro9w3DIY5pw3Rea9gN17J6NRJ1z0idoI8g6ycSFk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(376002)(136003)(39860400002)(346002)(366004)(451199015)(6506007)(6666004)(186003)(2906002)(6512007)(26005)(83380400001)(478600001)(2616005)(4001150100001)(8936002)(4326008)(316002)(66556008)(66946007)(41300700001)(66476007)(6486002)(44832011)(8676002)(5660300002)(31696002)(86362001)(36756003)(38100700002)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NnVJUWNHczNyQnE0V1BqVGZOYmNtRU5SNjFRV05lMUJlNGY2YXFGZ1c4SmlI?=
 =?utf-8?B?Sk5jYk5iSThZdkc0WXRHaFQ0UHNZVEduVlNtV0xEdlRtRE9YTENjNVN6VFVW?=
 =?utf-8?B?c2hjNzV4cjlLNGZpQThXMjZrcWhabDFMcFRJQU9xZk9aU0FsZDh3NnhQTWZ4?=
 =?utf-8?B?M2ZNdDN0ZldoOE0xeGdRK0IyRnVCa3dXZXdLSnY1TDlIMmlYRDFYSWlyY0VF?=
 =?utf-8?B?Qmc4VHRXd2xZUXBmNVVTajc4OWlVV29ULzMxWGp5NnJWaDl6Q05PeDBDNWRn?=
 =?utf-8?B?Q29YQmtCamhuUVpJZUhiSTFOR3UwOTNXY1NZTGVObjlKTVpEaGROdE1XKzhM?=
 =?utf-8?B?ZVpjNVNyQ1hiQVRuWUNKVEw2TElsVUI2MTZTamJINm4wSWx5Tkh2bVVGSzVU?=
 =?utf-8?B?dUdSdFRRcGVuYktBV05JdlYvb09ITFRFcW1JczB4Q1hPZ081VlhpaGNvcW9L?=
 =?utf-8?B?MUl4M2dkdWhtNmdLeHJHbjlEVGsxM0YwdUFXaXZlOURKU2ZnWW9KSVZtVGIr?=
 =?utf-8?B?b0F4V2dOYWV2aVFYV2VjVkwzc05ZczJhOG1OaldzbG1EUWxsd3FZWUNDYW5x?=
 =?utf-8?B?Zlo1cXpCdVJSUDk3N3dadzVqTjhMZXRFd244czBPQXN3WFBQZXJVY1ZyNmhP?=
 =?utf-8?B?K3BNUHZkUlQ0czQ5RlVtaVNMQzlCN0JZN3VIMmZDRk1tT3F2TVNFOGFteXVR?=
 =?utf-8?B?d09RSXlwckp0R3krYmRCMUkyTjg1OXRNYlVDa3Y3TzBJSGphc0owcXNZcUJl?=
 =?utf-8?B?ZkNsMDFzZk92a3F4MXpoYXRDRnFtcVFuV0hrejgyY1YyOHUvditldkNkNHB0?=
 =?utf-8?B?bll5K0Z6d00vbStBUFArNlY1cHNjZE1CWlQybXVTeUpXWkh6Wmh0TkNMa1dk?=
 =?utf-8?B?N3NEUjN5aHlqSXhXZDd5VGZWazg4QlNKQXVXRS9nS1Y3VXJjemQyRVVKajFB?=
 =?utf-8?B?bm8xWjFkOUc5TkpnV3VpejlHN1ZnTzM1L0FVcEpsVkVQY2JNSjd5OC9kQlU0?=
 =?utf-8?B?UEtmZUZ0ZW5yVXk5TmpERlpheTVVOUZvaFdzR2xrSnZNZFBWWFJNbXZwdlZt?=
 =?utf-8?B?WVJab1pubUNTZUg0VStsN1NLcnRpOVhmS2dieWFudzVMTmVIL1pPQ2NITGQy?=
 =?utf-8?B?MnRkbjZwekxabU9xYi8wWmhkVy9DRGhBQklwcGpBZDVZVTNEWTBCSkhzdjND?=
 =?utf-8?B?QnNjczMyS2VES29pTkMrckFYMm9KNWI2cFFXbi9hZ3hkRFR5K0dteGdhWnRH?=
 =?utf-8?B?NVpwZlAyS2FpZGd4TTdnb1JtM3p5QlQvS0U3V3h6MUMxa1pBRUlrT1BKK0w0?=
 =?utf-8?B?bnlRUjBNc2QyNzNQNkdoVFVMajQzSUpvTHl1MjhZZStPR3BqL2pNNW5UckZF?=
 =?utf-8?B?emFCYkxVcjhwZVB2QjhwWHNQck80cURCb2x6dXcyb3I1cFFwM2xNbmRLZnpq?=
 =?utf-8?B?OXVtRmI1WVZ0cjVNMlJUREtBTWxHUGp0UDBMVTJuWHVxc0lKaXo4SUVQZmt5?=
 =?utf-8?B?TDdHVnBPTG5kelZBQTh0c1lPK0xEVWhwVjJiSzNvREErMTZLU3VraUwzSTB0?=
 =?utf-8?B?WGRuQndCQjU2L243VjBTRzhkMzVCZWQ4b2VmNTNLcmgvYVB0ZzhnTldsdkQx?=
 =?utf-8?B?Z2ZDNHRSVUMzTnF4T2x2MDVGWWhIbXRzQmNMeWJZUU9WNGI0eTNXUTJpQWFS?=
 =?utf-8?B?YWFsbmhaelRLTWRsUDhzYTZLbkx6WDhiemRoaUZwMDVVRFpWaXRuUzU5MSsw?=
 =?utf-8?B?V3d3ZE13VnlTUXgyay9DY2Z1Z2Noakx4M2NESDQyYXl6RTB2UVhlYlZlQWxZ?=
 =?utf-8?B?N2tIakg3cmdESEg1MWhzeEVic1NLbVM5SWhwQktJRnhVMEJtRUZBWldueFNp?=
 =?utf-8?B?REdqSWFiZGdnV1FvVWorVWJkZGZpTC9YTXh1Y0djM01vZE5zRitxQWdiZjZI?=
 =?utf-8?B?a1ZYTktacjZ4QlRIUnRWVkRhVDFaQmVpbEgrcTlHV0pqMU9oZ3FidzBJK2M1?=
 =?utf-8?B?WUkvS3lYM05HdFVOOGxMUmFLZmJoNmFrZWUxRzNaaVEvSDVycFZFQmpzVHp0?=
 =?utf-8?B?eXVkUEszWGg1c04xR3lIU0djbzlXQ0tudlBmSVhCczFXcmNGSnk2Q2ZQQlI0?=
 =?utf-8?Q?Yqp9Hg8w3eZ4sCjJkgSAgQe/N?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d7606d1-42a2-4623-41e5-08dabb754c07
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2022 19:22:48.9645 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A4frhBGP0L5W06RucaYB2DFAl5gclT+YBFlhhk2S7IavevUjFchGseDqvCA5Y7KMVxYBHoozkBtCOclZ6BGtpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6238
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
Cc: Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 2022-10-25 um 09:42 schrieb Graham Sider:
> Hang on MES timeout if halt_if_hws_hang is set to 1.
>
> Signed-off-by: Graham Sider <Graham.Sider@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu.h    | 2 ++
>   drivers/gpu/drm/amd/amdgpu/mes_v11_0.c | 4 ++++
>   2 files changed, 6 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index 0e6ddf05c23c..9999c18e7d8e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -219,10 +219,12 @@ extern int amdgpu_use_xgmi_p2p;
>   extern int sched_policy;
>   extern bool debug_evictions;
>   extern bool no_system_mem_limit;
> +extern int halt_if_hws_hang;
>   #else
>   static const int __maybe_unused sched_policy = KFD_SCHED_POLICY_HWS;
>   static const bool __maybe_unused debug_evictions; /* = false */
>   static const bool __maybe_unused no_system_mem_limit;
> +static const int __maybe_unused halt_if_hws_hang;
>   #endif
>   #ifdef CONFIG_HSA_AMD_P2P
>   extern bool pcie_p2p;
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> index e14f314902b1..d09f92d38ad1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> @@ -129,6 +129,10 @@ static int mes_v11_0_submit_pkt_and_poll_completion(struct amdgpu_mes *mes,
>   	if (r < 1) {
>   		DRM_ERROR("MES failed to response msg=%d\n",
>   			  x_pkt->header.opcode);
> +
> +		while (halt_if_hws_hang)
> +			schedule();
> +

I think we should add the same in mes_v10_1.c to keep it consistent.

Regards,
   Felix


>   		return -ETIMEDOUT;
>   	}
>   
