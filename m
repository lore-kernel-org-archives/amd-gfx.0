Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01FE1C02194
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Feb 2025 13:47:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A222510E83D;
	Thu,  6 Feb 2025 13:47:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="DqFN/HOc";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2044.outbound.protection.outlook.com [40.107.212.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C653910E83E
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Feb 2025 13:46:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L29gyljEwA0EJlcm1ZeXwPTa5fWlwFT0so8i4RFX3f0rIZq6/+c6GoKH77pDL60doTA7IVnHnPt+6Jw0k5OylgfeZe9s7h3mwEpIzgVqQmTisR7MpzHMMGswKY8HKxLJyC9RTyZ3DYyslsk7qOJfq5GnuItseTzdXCYdMcA2V7fR5xGyzGaSbJXX1MNXWwpxEN/8gFckRqAgI4q+tmMqi0x1mI+Blb32CdIvFeMZFhg3tOuHNN8/x4PVwzzPprKroSv5XHKN65YzG8yUlVZ8FfrHkR1Ia/XWOwVyoN4ichIu9GQvNC3IrHUXw1jA429z85INS8ko4YnjBopmI+uTlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pW4ndsSQZTAqcj0OKQx9s1T9QcF5L153cX1olEsRokY=;
 b=Apo/+rthX5XrL8omG0eR964w+6YDQDtYrye75Ev/KC2b0sbPRAGhN3qxvvxJurxS6u+nP/cH4VcBCQ/oKtF8Fc/CR25LtZqfQvIMDJVdMC5KQs2mo6OZvGXbsIwTKZj3VwjUG2ChHgYAi5uvivF5oC7Nom9dTh7mkn5cPXQR9f+ocl3xcS3VP5xAGxXQRXMi7KRJETe+WIUrCDJ/aQGKMHjHn5ne59APqDc4iz/wO3DqTbpX5iUtmt4hkAGqSG6lIQrlhV3Krb8YQTo9BjHACzKQcjFFX1aOP7GQ9UlZ8MOL1MK1FxGAJnEIZG/YFkffyk2PAFFaU/RsvejQ/nD0sQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pW4ndsSQZTAqcj0OKQx9s1T9QcF5L153cX1olEsRokY=;
 b=DqFN/HOcZakj/AVSOUbOFd0vg7xXLgFakWEuZeJkYvg438MjilQ9v73xE7VlCDwOYquSWngxvORsJitvKe05q7hgApDxt6jlDETAbLZ1J5OrkVuZp2zFza0YL9slSNkhFwvDxhhT+gvbbxweYSYOfu6OM58IgstaPzYvystZV70=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY8PR12MB7491.namprd12.prod.outlook.com (2603:10b6:930:92::15)
 by CY8PR12MB8410.namprd12.prod.outlook.com (2603:10b6:930:6d::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.11; Thu, 6 Feb
 2025 13:46:17 +0000
Received: from CY8PR12MB7491.namprd12.prod.outlook.com
 ([fe80::217f:1ab1:9a5f:fecc]) by CY8PR12MB7491.namprd12.prod.outlook.com
 ([fe80::217f:1ab1:9a5f:fecc%5]) with mapi id 15.20.8398.021; Thu, 6 Feb 2025
 13:46:17 +0000
Content-Type: multipart/alternative;
 boundary="------------CgOn2Ccuwbm2N0otmEBK0gBQ"
Message-ID: <64a80c54-cac1-4ef2-a33b-4f66dac9bca8@amd.com>
Date: Thu, 6 Feb 2025 08:46:15 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 23/44] drm/amdgpu/vcn1.0: add set_pg_state callback
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20250131165741.1798488-1-alexander.deucher@amd.com>
 <20250131165741.1798488-24-alexander.deucher@amd.com>
Content-Language: en-US
From: Boyuan Zhang <Boyuan.Zhang@amd.com>
In-Reply-To: <20250131165741.1798488-24-alexander.deucher@amd.com>
X-ClientProxiedBy: YQZPR01CA0032.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:86::12) To CY8PR12MB7491.namprd12.prod.outlook.com
 (2603:10b6:930:92::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR12MB7491:EE_|CY8PR12MB8410:EE_
X-MS-Office365-Filtering-Correlation-Id: 43e60089-cff2-492e-bf9a-08dd46b4a167
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|8096899003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QTNoQVlNYmlaUm5TTXFYU1EwSko0eWVaSlIrWmJxd2NIeHA4MlN5TDBYTk53?=
 =?utf-8?B?ZGJtY1Z6dFIvdlM4QXhaaUE2V3hBclFMWitEdStLa0RDZm41WElkRG9DcG1F?=
 =?utf-8?B?cm1zZjB0cEFFYzNpVGRGcDlMeCtjNDZGN0M5TTVVR1ZLMVdrSEpPNnpnaHA5?=
 =?utf-8?B?bmFaSG5pL0hSKzJveG81TVRFVHZUT245TnZpQUhpMXVTajYxQ2dVVWJoa0c2?=
 =?utf-8?B?Ykx6QlQ4U2FGclNaazVNRnJLbU1Db3NibXpRTEhhM05GektjQXgwQlZHWFV0?=
 =?utf-8?B?TlhkQjhVbTNoVUIxWFJheEFqbVczTEdINmNmSW9OTlZIMUhwOTFaUW9rSU9a?=
 =?utf-8?B?Nm5Zcm1VQ3NBQkt0RUJnb2VScmJDSGRqWkVuQnord0UzMEUzWmRuSGNoWHRB?=
 =?utf-8?B?NktlYUI5K2N3bFJwQU5SdDgyNjJLRkJlelBWVjAwRFFEWFNISnNxbzU3NWNB?=
 =?utf-8?B?d2VwZ2YxcFNHQmVKVnNJQ3lJNXFFK1ExblgxU09QNjBhMlNRM1hLVXlFc0pQ?=
 =?utf-8?B?SnpVa2xRRXk5YTlPSXluSDM4UnlwNHJRWXBpRWg3c0lkTTJKZXZTakZFWjdW?=
 =?utf-8?B?bFh3WjB4RWl3RjljNFE0YWtRTm0ycVUwS0tyTnZmQzJ3eURzZzFqUDJBVno2?=
 =?utf-8?B?aHJKdWhyNnEycFdqMWZyWGVGSVJMOHNEYm1ZTlY3U2xIQ0ZtVkJBdFJQM0lQ?=
 =?utf-8?B?VVE5MWVmK2ZzVTUxeGQrVTBRT2k2TG51Wmx4bTVhTExkQ21sQ1Q1dWkrMytP?=
 =?utf-8?B?aWx0bWo2RlkrU1E3NHRrMHd5TUt3V0krRDdOU3QvWE5GUDZ3UU94OWlSM0dk?=
 =?utf-8?B?aXhwc0ZHRGRObnhhYngrYmlrM0tIYVdjRnJIL1hUdzZaL2liRUd5VmhxMHNK?=
 =?utf-8?B?Wm1IdW4yeVNKYitxVERWNmFpRzcraWU2MGZlV0I4SlZsVFZQMlhwL1F3Mmhv?=
 =?utf-8?B?ek9ZeHhqT3JoZHFldUduSXhTMVNpWmtxOGxiSFBjMmprczU3eW90eHRmNHZE?=
 =?utf-8?B?cEdaMHdZbktyZTRiSG1oM21ZZ2w3U3ZJRXNKUFR5SDFYcFNDcUVZTVNKeWc2?=
 =?utf-8?B?WUNBVDFoaWZxcHh0YzBjL0F0bHdmYnUweDVmWXViZFROdjg1cXlNNUtITHdD?=
 =?utf-8?B?bWk5NXRUc2p0SVg4YnlPQldwRTVsWE5SczRjeExjUkZYQnNTVTRoUk8yUFpl?=
 =?utf-8?B?UHNnQ3JaZ29QS0VJa09tMnlXNXZFT0JuMzB6U0tqVWdCQkc1emxDNm5mWXoz?=
 =?utf-8?B?WXI3Y1phdXlrZXpRUkNNcWdYaFB0TzZrdWtGUVR0b21MNVljNDNOeXByM2RY?=
 =?utf-8?B?MGFZWURqWUJHT3NWdmtQMjVJZ3I4WEUvRloyRHhsMVVodW9KWHRKNHBQZGlt?=
 =?utf-8?B?NmhoQkNaaytBUHJ1dTh0clJ5RjNWS2JrRnMyTHZDQlVvYnBmdXYyZ2x0eHZL?=
 =?utf-8?B?Z3J4c2JYUSs0U0t2dk1ZbkpNN2tZdzRRWGtIbkE0S09YbzUvQ2o5cm5VRkc0?=
 =?utf-8?B?SG8zeDJDYXlsMFNTSHg0My84dTlkenRDNlRYSTdCWHJjNGttU05vTisvZmF1?=
 =?utf-8?B?WVBON1lVVzFCQVRNSWNrSUkzTURVMFRTbTk5L3gwcG9URGhEdkQ5YmFRaWNM?=
 =?utf-8?B?UlJhQ3g3NzNrTWI0czhQTkQ1ZWFoMElBWXFlWVREUndDTzRDcUVUOEQ5cmN2?=
 =?utf-8?B?Q2hXSXpJUXhEc09QZVBtVE1MSmNYeG1sU2ZMd3c3bzB4Wm9XTlA2VVcrRHBB?=
 =?utf-8?B?QXQ5dTdnWE5uSzRYdHQ3WnM3OXJ1Vm90aVljSU9pZDJFb2J5YWRmSGs4VHNF?=
 =?utf-8?B?NHR5eUcxT2VNOTdUejkxZ0dacU8rRUJFOXZEZXdHaGRQc3BtYUhHR0hRTUpY?=
 =?utf-8?Q?qqOh/EGoLxuc0?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB7491.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(8096899003); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RFV3SDFpOHI5OE1ENHRWdmNmUzdRdkVDbDhIZlZHSzEwTVZZNWNCSnhmUThB?=
 =?utf-8?B?bzl2dms0Uk8yTEZNVFBsaGdpcVJuZytpRVVqUG4zWTAwN01OSzRDczZybU9m?=
 =?utf-8?B?dW16Mmp3NE0xeVNYcllRY1Z4dlVPZWsrZUxmTE4vWVNGbWxicHFIT0VxQnJY?=
 =?utf-8?B?MTN3bDE5ZDhtUXNFcmFPSDNzYXhYcDArOUVFNjJtUGZHK0NIVzVoUlBaUG5J?=
 =?utf-8?B?OFZ5SUF4WHJ0L1djbDBXREpsMndvVy83NlIzTDNTL0IrTzljcFJFdm00LzVr?=
 =?utf-8?B?MXduTHNrbkJkMUZXMW5Qc0lIbHBRSlNKc1B5cDhqTTJ5REpMUUlGTnYrZHpo?=
 =?utf-8?B?cjErdFRlQTh1d3paNnRSN250M3BIbEQ5cDNuZytnUG1jakhicFIxRVgxYzZw?=
 =?utf-8?B?Y3crQjVaNEc0WkFuRk9aaVZ1ckdJVkFwWTM3Zml0WHh4QlNyZ1I3Nk9PRnVE?=
 =?utf-8?B?bithMTRPTk82Q0k1Nk5NNzRDOXJoVC9XRThrYzk4cEpmbkswWTRLYnp2dFMz?=
 =?utf-8?B?eGJmQ1BmeVZXcTFsR3cvODZkbW16YzFGZ3BrZkpiZ052ZXNZNWVCOGxYSC83?=
 =?utf-8?B?MlYxcUtLem9FRHdrcTlxamVHaTJiQ0c4MktqNkM0WDQ3OWpRQjVRQitabTNo?=
 =?utf-8?B?eTFLOU55azA0SE9DQ1MxZmRZSWw0aVBFdTFxMlFJdVovTGcwRXJ5WWRzdjEy?=
 =?utf-8?B?MkphKzZIaXc0aE4vOVQ1NWM2VTcvVWd6dEhNQWtWRDNjZi94VkxGdDhzcFFB?=
 =?utf-8?B?YjdIaU41MlB1aXFFdjM0aVluaExuRVIwSFFULzQ5ZS9QaU56SnlWUnFOOWw3?=
 =?utf-8?B?UFlBZGdWMDE4RkFMNmNpS3QyYm9OK0Qvekx2dGdlZVY3Mm5na093TlBHdWk1?=
 =?utf-8?B?M0l6VkdmWEpHZzQrKzJicit0emNNREsxcDhTUUxOaEJxQkc5RjhrL0Q5MVFt?=
 =?utf-8?B?ZWlobitPdG50djdWZmFVUXBpTWxiTjg5TmZRZmZmS2tMTi9yL2NPS0NHbENB?=
 =?utf-8?B?eE94eng1VlViL216cGVnMlJWZEtzQkloQWdOcDk2MEhhRWEwWGQzbU51Y2F6?=
 =?utf-8?B?ZGswTnZ4ZnhENVB5ZkdTdUUrL3NYb0p6TjFFN2h6bUUybjVnVGRtTTdaSUhi?=
 =?utf-8?B?ZjFReTVDbk8ydHRmSk9WZDYvcXJCWGJvTkRYbk9DMHp3dmdmRStyaGRkZnl1?=
 =?utf-8?B?cmVtYkFqYnlERmdMQVUvVm1KSHpwNkRLcGp3SHB4R0FMK0VDNXpidHNEcFgy?=
 =?utf-8?B?YU1CUVBOckNKWit4dGxrWWY4UzQyL1J5QVFtYmFvMUFFak9yMjQ5dEcxM2tJ?=
 =?utf-8?B?ekZKNWtNVU5mZTBsUjVHV0dneDhWSGZQUlY4aWVPWHRjSGtmS2xUZ0JmVHQ4?=
 =?utf-8?B?RnpJR1Rjd0drM0dlMTgxTUhWMXdINGwvSlV5UkNGNWszM1ZJTUhVd1ptWmVX?=
 =?utf-8?B?UkkyWjFXVzRXaHl3U1ZaVjJmUE80UWF3T0VKVnpoYmowN3R2dHZob2lVU2o1?=
 =?utf-8?B?NG9PNEM5ZzVDdnNpZkJPUTdra3U4YTFUTTdrck51cFBtS2VMTnVPaDZ5Ty9l?=
 =?utf-8?B?ME9rcHlJc2pmR0RVWFVtMWxBYzF3YW9SL3VFVEgxS2pQOTh0ZjgyNWd0WEpE?=
 =?utf-8?B?ME9EdnFaZEZDQ3ZqQlZ5cUlpZjFmcmZSdWpUVHNxUUc1S0EvNnVCQzBqdVJn?=
 =?utf-8?B?TVkraDVPTE9mdTlCWkVjd1BYOUZjT0c4N25MNTkvVkhDUHdHelVTZDFCQW9w?=
 =?utf-8?B?TnhwYXNiTXVxQXVvb2Qvc0Z2ZkN1OW5INVlvYnV4Q04rWjdYdzBvbUlSYmcw?=
 =?utf-8?B?YURxTTNEcUZiU2tlSjNWa0NCcTVManYvNlF0aEJIL0N5WDM4VHBPaGVPdFVF?=
 =?utf-8?B?SXIrdjJmQjgxSCtDcXhTQnpUb1R1ckVIWXU2ZFkvdjdudjhOTG85MTl5dUxy?=
 =?utf-8?B?WXgyQTdFbDVEcVluaVltUnE4Z2hKcEhYZWJCWGNGa3B4YWZqNkRtN0gxVVVZ?=
 =?utf-8?B?VFlqMjczWDZsMjhZR2VlVmZtd0MvM2FUVGFOR094aE9yaG0vaDRlQlhkU0tq?=
 =?utf-8?B?SHdETE9oRjU0V0U0Nlp6dC9ib1N5bm00bWlxVk5jUzlrMWhOMlljSVFBNjR5?=
 =?utf-8?Q?JBlAxmfglldlY5oii5iJk6Utc?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43e60089-cff2-492e-bf9a-08dd46b4a167
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7491.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2025 13:46:17.4403 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0fcliO+f78pmqczeTu3KuSfaXb0zbu4yEBMicu7PoVFSCKsBLSST1FC48BKsYxaOp01lSMT8vhiPZudt+ReOCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8410
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

--------------CgOn2Ccuwbm2N0otmEBK0gBQ
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 2025-01-31 11:57, Alex Deucher wrote:
> Rework the code as a vcn instance callback.
>
> Signed-off-by: Alex Deucher<alexander.deucher@amd.com>


Patches 23-32 are

Reviewed-by: Boyuan Zhang <Boyuan.Zhang@amd.com> 
<mailto:Boyuan.Zhang@amd.com>


> ---
>   drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c | 32 ++++++++++++++++++---------
>   1 file changed, 22 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> index 3d56660fd90a9..fdb954c7377eb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> @@ -85,6 +85,8 @@ static int vcn_v1_0_stop(struct amdgpu_vcn_inst *vinst);
>   static void vcn_v1_0_set_dec_ring_funcs(struct amdgpu_device *adev);
>   static void vcn_v1_0_set_enc_ring_funcs(struct amdgpu_device *adev);
>   static void vcn_v1_0_set_irq_funcs(struct amdgpu_device *adev);
> +static int vcn_v1_0_set_pg_state(struct amdgpu_vcn_inst *vinst,
> +				 enum amd_powergating_state state);
>   static int vcn_v1_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
>   				enum amd_powergating_state state);
>   static int vcn_v1_0_pause_dpg_mode(struct amdgpu_vcn_inst *vinst,
> @@ -106,6 +108,7 @@ static int vcn_v1_0_early_init(struct amdgpu_ip_block *ip_block)
>   	struct amdgpu_device *adev = ip_block->adev;
>   
>   	adev->vcn.inst[0].num_enc_rings = 2;
> +	adev->vcn.inst[0].set_pg_state = vcn_v1_0_set_pg_state;
>   
>   	vcn_v1_0_set_dec_ring_funcs(adev);
>   	vcn_v1_0_set_enc_ring_funcs(adev);
> @@ -276,13 +279,14 @@ static int vcn_v1_0_hw_init(struct amdgpu_ip_block *ip_block)
>   static int vcn_v1_0_hw_fini(struct amdgpu_ip_block *ip_block)
>   {
>   	struct amdgpu_device *adev = ip_block->adev;
> +	struct amdgpu_vcn_inst *vinst = adev->vcn.inst;
>   
> -	cancel_delayed_work_sync(&adev->vcn.inst[0].idle_work);
> +	cancel_delayed_work_sync(&vinst->idle_work);
>   
>   	if ((adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) ||
> -		(adev->vcn.inst[0].cur_state != AMD_PG_STATE_GATE &&
> -		 RREG32_SOC15(VCN, 0, mmUVD_STATUS))) {
> -		vcn_v1_0_set_powergating_state(ip_block, AMD_PG_STATE_GATE);
> +	    (vinst->cur_state != AMD_PG_STATE_GATE &&
> +	     RREG32_SOC15(VCN, 0, mmUVD_STATUS))) {
> +		vinst->set_pg_state(vinst, AMD_PG_STATE_GATE);
>   	}
>   
>   	return 0;
> @@ -1818,8 +1822,8 @@ static void vcn_v1_0_dec_ring_insert_nop(struct amdgpu_ring *ring, uint32_t coun
>   	}
>   }
>   
> -static int vcn_v1_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
> -					  enum amd_powergating_state state)
> +static int vcn_v1_0_set_pg_state(struct amdgpu_vcn_inst *vinst,
> +				 enum amd_powergating_state state)
>   {
>   	/* This doesn't actually powergate the VCN block.
>   	 * That's done in the dpm code via the SMC.  This
> @@ -1829,10 +1833,8 @@ static int vcn_v1_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
>   	 * the smc and the hw blocks
>   	 */
>   	int ret;
> -	struct amdgpu_device *adev = ip_block->adev;
> -	struct amdgpu_vcn_inst *vinst = adev->vcn.inst;
>   
> -	if (state == adev->vcn.inst[0].cur_state)
> +	if (state == vinst->cur_state)
>   		return 0;
>   
>   	if (state == AMD_PG_STATE_GATE)
> @@ -1841,10 +1843,20 @@ static int vcn_v1_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
>   		ret = vcn_v1_0_start(vinst);
>   
>   	if (!ret)
> -		adev->vcn.inst[0].cur_state = state;
> +		vinst->cur_state = state;
> +
>   	return ret;
>   }
>   
> +static int vcn_v1_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
> +					  enum amd_powergating_state state)
> +{
> +	struct amdgpu_device *adev = ip_block->adev;
> +	struct amdgpu_vcn_inst *vinst = adev->vcn.inst;
> +
> +	return vinst->set_pg_state(vinst, state);
> +}
> +
>   static void vcn_v1_0_idle_work_handler(struct work_struct *work)
>   {
>   	struct amdgpu_vcn_inst *vcn_inst =
--------------CgOn2Ccuwbm2N0otmEBK0gBQ
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 2025-01-31 11:57, Alex Deucher
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20250131165741.1798488-24-alexander.deucher@amd.com">
      <pre class="moz-quote-pre" wrap="">Rework the code as a vcn instance callback.

Signed-off-by: Alex Deucher <a class="moz-txt-link-rfc2396E" href="mailto:alexander.deucher@amd.com">&lt;alexander.deucher@amd.com&gt;</a></pre>
    </blockquote>
    <p><br>
    </p>
    <p>Patches 23-32 are <br>
    </p>
    <p><font size="2"><span style="font-size:11pt;"><span data-markjs="true" data-olk-copy-source="MessageBody"><span data-markjs="true" class="mark5quw442ch" style="" data-ogac="" data-ogab="" data-ogsc="" data-ogsb="" data-olk-copy-source="MessageBody">Reviewed-by</span></span>:
          Boyuan Zhang <a href="mailto:Boyuan.Zhang@amd.com" title="mailto:Boyuan.Zhang@amd.com" data-linkindex="2">&lt;Boyuan.Zhang@amd.com&gt;</a></span></font></p>
    <p><br>
    </p>
    <blockquote type="cite" cite="mid:20250131165741.1798488-24-alexander.deucher@amd.com">
      <pre class="moz-quote-pre" wrap="">
---
 drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c | 32 ++++++++++++++++++---------
 1 file changed, 22 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
index 3d56660fd90a9..fdb954c7377eb 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
@@ -85,6 +85,8 @@ static int vcn_v1_0_stop(struct amdgpu_vcn_inst *vinst);
 static void vcn_v1_0_set_dec_ring_funcs(struct amdgpu_device *adev);
 static void vcn_v1_0_set_enc_ring_funcs(struct amdgpu_device *adev);
 static void vcn_v1_0_set_irq_funcs(struct amdgpu_device *adev);
+static int vcn_v1_0_set_pg_state(struct amdgpu_vcn_inst *vinst,
+				 enum amd_powergating_state state);
 static int vcn_v1_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
 				enum amd_powergating_state state);
 static int vcn_v1_0_pause_dpg_mode(struct amdgpu_vcn_inst *vinst,
@@ -106,6 +108,7 @@ static int vcn_v1_0_early_init(struct amdgpu_ip_block *ip_block)
 	struct amdgpu_device *adev = ip_block-&gt;adev;
 
 	adev-&gt;vcn.inst[0].num_enc_rings = 2;
+	adev-&gt;vcn.inst[0].set_pg_state = vcn_v1_0_set_pg_state;
 
 	vcn_v1_0_set_dec_ring_funcs(adev);
 	vcn_v1_0_set_enc_ring_funcs(adev);
@@ -276,13 +279,14 @@ static int vcn_v1_0_hw_init(struct amdgpu_ip_block *ip_block)
 static int vcn_v1_0_hw_fini(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block-&gt;adev;
+	struct amdgpu_vcn_inst *vinst = adev-&gt;vcn.inst;
 
-	cancel_delayed_work_sync(&amp;adev-&gt;vcn.inst[0].idle_work);
+	cancel_delayed_work_sync(&amp;vinst-&gt;idle_work);
 
 	if ((adev-&gt;pg_flags &amp; AMD_PG_SUPPORT_VCN_DPG) ||
-		(adev-&gt;vcn.inst[0].cur_state != AMD_PG_STATE_GATE &amp;&amp;
-		 RREG32_SOC15(VCN, 0, mmUVD_STATUS))) {
-		vcn_v1_0_set_powergating_state(ip_block, AMD_PG_STATE_GATE);
+	    (vinst-&gt;cur_state != AMD_PG_STATE_GATE &amp;&amp;
+	     RREG32_SOC15(VCN, 0, mmUVD_STATUS))) {
+		vinst-&gt;set_pg_state(vinst, AMD_PG_STATE_GATE);
 	}
 
 	return 0;
@@ -1818,8 +1822,8 @@ static void vcn_v1_0_dec_ring_insert_nop(struct amdgpu_ring *ring, uint32_t coun
 	}
 }
 
-static int vcn_v1_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
-					  enum amd_powergating_state state)
+static int vcn_v1_0_set_pg_state(struct amdgpu_vcn_inst *vinst,
+				 enum amd_powergating_state state)
 {
 	/* This doesn't actually powergate the VCN block.
 	 * That's done in the dpm code via the SMC.  This
@@ -1829,10 +1833,8 @@ static int vcn_v1_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
 	 * the smc and the hw blocks
 	 */
 	int ret;
-	struct amdgpu_device *adev = ip_block-&gt;adev;
-	struct amdgpu_vcn_inst *vinst = adev-&gt;vcn.inst;
 
-	if (state == adev-&gt;vcn.inst[0].cur_state)
+	if (state == vinst-&gt;cur_state)
 		return 0;
 
 	if (state == AMD_PG_STATE_GATE)
@@ -1841,10 +1843,20 @@ static int vcn_v1_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
 		ret = vcn_v1_0_start(vinst);
 
 	if (!ret)
-		adev-&gt;vcn.inst[0].cur_state = state;
+		vinst-&gt;cur_state = state;
+
 	return ret;
 }
 
+static int vcn_v1_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
+					  enum amd_powergating_state state)
+{
+	struct amdgpu_device *adev = ip_block-&gt;adev;
+	struct amdgpu_vcn_inst *vinst = adev-&gt;vcn.inst;
+
+	return vinst-&gt;set_pg_state(vinst, state);
+}
+
 static void vcn_v1_0_idle_work_handler(struct work_struct *work)
 {
 	struct amdgpu_vcn_inst *vcn_inst =
</pre>
    </blockquote>
  </body>
</html>

--------------CgOn2Ccuwbm2N0otmEBK0gBQ--
