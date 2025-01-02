Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58175E77188
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Jan 2025 07:27:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EA96110E2FB;
	Thu,  2 Jan 2025 07:27:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="sZL/GbDA";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2041.outbound.protection.outlook.com [40.107.237.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C58B210E2FB
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 Jan 2025 07:27:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BpSMzEZvvnjbkj6Tzzm10h+IGbUsxa9LROuH3RSq/Sm2GTbr/oNFHblenBig+a0OsfVAbCJfSnX64cUR0JtiRDvo9C2ogir9E59oGdR+Gj0FbrilsoQ8VW1jHXaxPLHFS/DM0nUF8rI0g/ZTpX5mP2jB+YF10MfkMTEj2fCTRwZm7SzUVj2s6E/KaGIn70vM3Bpde8xyXmUvcQZvhWzP0CscOBhTAYdNlL7Zie+ueiB478dUi2PVzHBHlaxIYdXM94AsqzrnsivnnXWOkelPMjXnRnRyY+W+mFsrHZfLb8SyvUuUIqCaryXc7v7TBPoxYUZxLICOumRLE9ZhFVUmsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7xa+fdT8e6ctsbDF38r3pcmWi+symttYHnz7zaVhhbw=;
 b=YM5BINmPhUqwC3VKfHmCzhzUewzotkGv3qjTw2kHo0yLchP5DWR4VYPCXyxbwwlbqCb2lbKa37OBb583hoxWqJPTp9lVeEjJ2wUGam5xmCX7YLyJzHqzO48KryaopVaVJPsz+ru8qmqYhXtUy7HUGCeHeeBRv7IcIpYY8mDemFrgT/3vKciWSpMG3U0bOjDkUpi81yDL+Ca5Y4YXnE6gyX7HvIbeBL606sQdGclpdSaV6+FnxTKfvQ7YeapfPc0tibVG0Bm0H43K4iEovUPRvwmHnyfpn8osV9vdYj6Zh7mORgnWAV7PiYAP5HxRFfyOaCJ37XF3UF8xIIJrnuh5MQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7xa+fdT8e6ctsbDF38r3pcmWi+symttYHnz7zaVhhbw=;
 b=sZL/GbDAPLYyrqTR9UKydUKstL82UURur9+Ti1GmRVt2G0/xqh3HNhNfY+/B1ol0o9Su9aexmHy95ywo2EfPrGJhW/8qagtBfWPymOTyIUi3UkM29rh15jS/enk7rDCsy+qCXntwAbdIhRqg7alb9ZVe5nTtWSu9wWYQq1r4FRY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN7PR12MB7835.namprd12.prod.outlook.com (2603:10b6:806:328::22)
 by SJ0PR12MB8615.namprd12.prod.outlook.com (2603:10b6:a03:484::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.12; Thu, 2 Jan
 2025 07:13:11 +0000
Received: from SN7PR12MB7835.namprd12.prod.outlook.com
 ([fe80::ea3a:4720:99cb:32d8]) by SN7PR12MB7835.namprd12.prod.outlook.com
 ([fe80::ea3a:4720:99cb:32d8%5]) with mapi id 15.20.8293.000; Thu, 2 Jan 2025
 07:13:11 +0000
Message-ID: <66d90655-b070-45e7-9222-28e65007e50b@amd.com>
Date: Thu, 2 Jan 2025 15:12:49 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: test release process eviction fence before
 signal
To: Prike Liang <Prike.Liang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, Felix.Kuehling@amd.com,
 Christian.Koenig@amd.com, Harish.Kasiviswanathan@amd.com
References: <20250102063059.2221560-1-Prike.Liang@amd.com>
Content-Language: en-US
From: Zhu Lingshan <lingshan.zhu@amd.com>
In-Reply-To: <20250102063059.2221560-1-Prike.Liang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYAPR01CA0103.jpnprd01.prod.outlook.com
 (2603:1096:404:2a::19) To SN7PR12MB7835.namprd12.prod.outlook.com
 (2603:10b6:806:328::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB7835:EE_|SJ0PR12MB8615:EE_
X-MS-Office365-Filtering-Correlation-Id: fdca963e-bd75-4cec-bbdc-08dd2afcea8b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UXZtcVd1WS9mdGlNd09DbWY1aEhmdnordUxsZTRHSDlKMmxEMFlMQ1REV0dC?=
 =?utf-8?B?bWR6aCt2QTlTUEM4UkE0SzNES0pqRXNlQURsRjJHMHJqNFJXdW5CRWpKcURn?=
 =?utf-8?B?bmdzVTVlTjJRbzlJL0JQK2xKQ09JUjJMNzgvd01VRnN0OXdUZDA1RTZZemxx?=
 =?utf-8?B?VmpyS1VmT1FubUtJRVJLOTQzN3JVaEdaZmpranVneGIyak94S3FsQnpQWk9D?=
 =?utf-8?B?aXB2bUt6UExrVmVrTUFmQy9ZYzYvRlVLQjRoMDNZNXU0WjM1MmxmY3NNTXZy?=
 =?utf-8?B?SkVycWxUSEl4MGtZYzArdjBDdmtCaXVGMkk4RDc4Mnl4TFI4QTNTUUw1UFQx?=
 =?utf-8?B?Z1RxdjRLRURHRzI3SEpuWk1hVUk0QURodGt2bmJRYjZ1b09SalVYWmxtcGhW?=
 =?utf-8?B?dEp1a2pjbjQ1OENzNnYxS2MxK2k0QS8wN3JDOXRLem93QWVybEZQMXpuR0Rs?=
 =?utf-8?B?QmZWQ2tHUDNRUWtwSTM3eHZpQXVTY0F6Znl5UVFGWTNDYitDMGJ0ckhEN05O?=
 =?utf-8?B?M1VDc1hYdk5pbFB2ZGVZVXRueGdIMlNJclhPL0ZOUE81N0ViaEdxUHVpbmc5?=
 =?utf-8?B?djVCNm1YZWhlL2wrL1dMdmtHeDhDcTlmNndxaTdYY3N4TGo5cndyd1pncHE2?=
 =?utf-8?B?b1oyaVBFTjh0M2xVY2NxZTUwRUEycFkyTG1vWHdQQ0lXVkNwZXVVd1Z0VzZj?=
 =?utf-8?B?UVd0ZmFHcS9BYlcvdE1jZDVYRklYTm9wdGFtVVVQaDVmL2J4M2VseWNReFE2?=
 =?utf-8?B?QjUwaDYxcEh6cEdON3pobVcrVHUzVUNoQVdNS1ZTL0VpdmxvcGZzWHdWQkM4?=
 =?utf-8?B?T1NpNmwwdlYranVjR1RLd1VpWUFzaGt3b2ozSEpNZW5yWXpGSkxSZlEvVGRK?=
 =?utf-8?B?YmpDRUR2VGkyMHArbDdEOERwTWVnMm04a2ZVUUwvUU9WNjZmWWRvcCsyeG5y?=
 =?utf-8?B?WXVSUjluSVM1ekdzM3h6ejAxRVZCa0ZHWFJVTmZFQS9NWGVwd1RjMFRRVCtL?=
 =?utf-8?B?NmRSS0YzK2JIaFRPNWpFaGFVZVJkTmZZOHdSaDIreWdRcm90Q3c3TTF0eEU1?=
 =?utf-8?B?TytiUmk5amVZYitGc09xTGZabFJIV3ArYmV0KytoOWNPVEU0OW93am1GaGFJ?=
 =?utf-8?B?TW5SaE1JVzJvemlHSlR6U0JNNURuY3JzZjRuaUJhOG9aWTVzM3lLT1FwRndz?=
 =?utf-8?B?anZheWF3VWZhdVV3VXFsdU9xandQa2NIaEoyVTVJc2tWVTZCVHVOb294SDNR?=
 =?utf-8?B?TWpyNVRiWmN6WWs3MGpWYVphM0FhZVZqcm5kcFRhZzc2QUZ0LzdqMHcxY1pT?=
 =?utf-8?B?bmhXbUplS0xLcysyODFvcEQvMGZMNTVhUDI1WTdQY3Ivc3dlaWsyU3ZiWDN6?=
 =?utf-8?B?c0VLZWozZTZRdkV2Zm5SUFltalVZcVJHNWZNODJxbnBMeXJLdzhFZ2VIWVFh?=
 =?utf-8?B?aU90TTBnclg3RDdMZUVROWR0Qmg2UTYzVzR3enQxaitpamRnS2RMcFRrTkQ1?=
 =?utf-8?B?dGNRN29GUG1wdWNnWUtkS0k4OEpEcllweVNDOGFYU1p2WDRxWG0vcTN6TWRH?=
 =?utf-8?B?MUJiQ2RPUG1VM3hINjBhS1ZUY2VWRFROVGs0eTIzL01kT2dPaXhUT2taaUVQ?=
 =?utf-8?B?M0FSNGNNMHV3NWgwRnF6clhUMHhMYTl4RnltU3c2MjZCamFGOHExaFJDN2ZY?=
 =?utf-8?B?MnlaTGgyRzNtamR6TjNlTGdHVk9HTFk0RU9sdFBCSTREalhXRXU1dEpmeUh5?=
 =?utf-8?B?bGM1VVN0bG9oRTNhaXhKai9IeVl2dSt5UGhxTmdqbGNNVUtVZzdIREFtRjBu?=
 =?utf-8?B?dmx0THgxdVRTRm5oMDdjUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR12MB7835.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UkttV2FnUGpCTXEyb1RKV214eThldHh5NlVJMUVCTWpVekV4Unl3UjlvVmJK?=
 =?utf-8?B?WXJGcFVkcjgza2xVNEtWUjJxR1Irc29Xa0JPWVZUSHhpMFU0bXN2ejAwWHRM?=
 =?utf-8?B?NXJxL0xoWlRCclpFek5IRlYwRGJ4Z3JoZnY5cE1laWl4bmlBdlAvVlVZT21C?=
 =?utf-8?B?KzdyS0NEZHAxSnZRZ05EN2ZkY09zeXhDaEF2RWk3b2Rsa29wdkRjeEI1MVY1?=
 =?utf-8?B?Tm81b3JuRWk5NThZYmlQN005VTVYZU5ndUEvZVd0RlFNV2FvQ3AwQ2ZLRTdh?=
 =?utf-8?B?Zmx2Y2crVHkvNGNoeng1WWtFdUtFVWdqWE5SSm54ckdqRFcwa2NDNG9YV2c2?=
 =?utf-8?B?clRjbkJPVy9KbWFqcjJRbGVMKy93b2dlL0tYUUhJbVorSGtBODBZeDl0RTZi?=
 =?utf-8?B?SnRRdkZydTdHcXpEbDNVaGJKOW9VREdRWTRsT2d6Q3RyZnR1UStrNTFkL3RL?=
 =?utf-8?B?TXNDZUZoZzlNdThDNUxUdzlzbWlaV0tDNmpPWk5GNndCNlA2dCtuSzNBcldL?=
 =?utf-8?B?OU9udzhPM3FlZ2dRTU5PbHFFL0RmS0pOaHRnaUZtSnp4akl2QmhWNWVUeGda?=
 =?utf-8?B?ei9YZmRhTy95QVQrVWV2YjE3QVgvcVM0bHNKaHJGYlZaeFpqZFkzM1FFY2tS?=
 =?utf-8?B?QjJWRW00aE81SVdiVURCSmk3eTgwSWlBTVRBNmpIVjExellnMVZFWU40NTZv?=
 =?utf-8?B?YytKQ1N2amY3Ynl5QU9mU3kwU3ZuZzhoUitUYVZyS090UlFaTEFyRmhDYTNo?=
 =?utf-8?B?aTZqRXRYbEZ3WkN3Z3ZaNlFLb2paRjh3OFNFdlNKNVpxYzlPV3JsdnIvU1Ns?=
 =?utf-8?B?UVZTQ25qQnBUZVpYZDV2MWM1dlBrVzVrb2IrWGFLaEcyRytUTWpqaUpRK2lp?=
 =?utf-8?B?TkxwRnpwdENGOHVzNFVoYWV1MlFaQWlBTkVPYTAzem4vUzR0bENqTENDem5O?=
 =?utf-8?B?bUpiOXN6bEtTU2RiOEdiOUl0eTJsYkR1dXFJSjRZd0lER2VVRzFiK2tZbjdt?=
 =?utf-8?B?UHd5MFBCcy9UK3hFWDJUTkhUUGRtUTVuYlRYdWlIeHdXM3NpQkRtZDFjYnBQ?=
 =?utf-8?B?OXdxeURRcDJMQjg1d3VCSjFmanpYcEdWQWpMalBmdVJFRDFGaDhDMUdVam5J?=
 =?utf-8?B?N3hnRlh6WUNrODlzNVBWd0xwODg4djVqT1huS21iWWxaeVRoRTg0VktYUlpM?=
 =?utf-8?B?RWk1ZysrRDEzbFFsMkg1K0pvUDRIQUlmZ3FkQk56OGNmT2xrY0RlNml6VWpD?=
 =?utf-8?B?YVhaYk1tejVDL0RmZ0dsajAxcGlrWS94ZEtUcmR6Z2FKZHZxZVZjRUpxSFUr?=
 =?utf-8?B?dVlqRjdQMU1PQThjdVRERE1jODA1ZVhSNC9EYW9tSWdZWmhMeWNuV09pTktr?=
 =?utf-8?B?WW5XN3p5enk5ZFVIUXVlWEFleXk5ZDlCMnAzeG13WXJDQnMwOEhjTXNpNVFF?=
 =?utf-8?B?S3NuaWN2Z2ZLRnIySVUySE9Eay9UQXRYdmN0SGhXVGVYNGZHVm5WYllwYU9l?=
 =?utf-8?B?dy9zbFBPWkQ0RmF0dFhPZnJjNWxJalVERDAyaFJvQkk4TEhZcDRwREtUa3pk?=
 =?utf-8?B?ZjFYYkVSVTlZaGNGRnQ5dkFmbWRGZUxHV0c4ODF1T0ozTHY4MCsreE5EVDVq?=
 =?utf-8?B?Qlo2TXUySEZlNDRDVkdKWW8vbDhPcHZzK2twRUJJZUpPaGN2RjUwSXI0dVJX?=
 =?utf-8?B?cjc4RTJNTTNVbmlSdDQ1bHhXZ0pRcnFVdVJlKzM3YjBBYzlQQWRNTkd2RDZh?=
 =?utf-8?B?ZTR1QWl4YzBKdXZ3ZVFKTGYvSVZKT3FFL0VYSUhqb2QveXIzOURIekFPelBU?=
 =?utf-8?B?ZmNzbHB3QnRZTXJuMU5scmw2ci85Zi84VGVVQmpBRmdRVGRkQzJPNE45Vk1F?=
 =?utf-8?B?eUcxUXdoc2pqS1V2YXlremZnNUZMRXFqdys2V3pKTmlYaDVpc0JmSW1ZbG1n?=
 =?utf-8?B?TUJqdHlzbDMySXI2NklsUnZibVJlYVpmYy9Ed1NFT0UxeFE3MjF5L0VxOG9u?=
 =?utf-8?B?YzJ2cEhMcEsyRU9WaldCVCtsT3Zwa0JITlZBMjgxbGZzNmZYWjdkRFpqa3BD?=
 =?utf-8?B?c2lOMEpDOHVVWXBtbE90OStFVkNTcVB4cWhpbGJweE5tdHZuWlRLQkpaMzB2?=
 =?utf-8?Q?dM0P19geGetPRtKSMfHdCKsAH?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fdca963e-bd75-4cec-bbdc-08dd2afcea8b
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB7835.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jan 2025 07:13:11.3784 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p+h+Br3g3dDkP0gMuVAdecputvHharJSB506w5dw8LxZ1Jiuui8cjU3lg3XjvZeIqLJ4juvVU7e4/MzesWmB8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8615
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

Hello Prike

This issue has already been fixed, please see:
https://www.spinics.net/lists/amd-gfx/msg117071.html

Thanks
Lingshan
On 1/2/2025 2:30 PM, Prike Liang wrote:
> It requires to validate the release process eviction fence before
> signal the fence.
>
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_process.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> index 0976b5b0e8e8..083f83c94531 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> @@ -1160,7 +1160,8 @@ static void kfd_process_wq_release(struct work_struct *work)
>  	 */
>  	synchronize_rcu();
>  	ef = rcu_access_pointer(p->ef);
> -	dma_fence_signal(ef);
> +	if (ef)
> +		dma_fence_signal(ef);
>  
>  	kfd_process_remove_sysfs(p);
>  

