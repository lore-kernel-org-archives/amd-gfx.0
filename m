Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC496C7115C
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Jun 2025 07:53:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5385E10E684;
	Wed, 25 Jun 2025 07:53:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="B422JRZF";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2067.outbound.protection.outlook.com [40.107.223.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 06F5110E684
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Jun 2025 07:53:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GsE3E6zpIP86HAqET2eaT/ofcTEwWZLv4z3bcOMnaQX+QaSyQO6RqijiaZ6rQiydA5SNJEC6O/oFl7A5r0FOA1OLR9sbcGlGsIHg/Uq3yJIFHGmChRu+PM53097NQAvRkQtiwOjjhjtwlkHuJZLdq7XKUUdabnhcQrui7viL345sNf9fn6iT5ZtqlPrVW86TDvf2aXStpXVgaQoN1obHWz2zoNj7gmBHXHbnqp+I5TgjV4PHF7fOngwXYxj6P4jzZXGSQHEPkFW5LasX1MuuuVnyzuGkFdTt1wDC/DX6GQJ6t3I/TrabjGKynOiY4/yV/M/9Sm9UN4yaQqLuRLQvkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6a0/wTlEEu0B9AUeycwlp/r1qlJqQTsW/PlMzgFcK+c=;
 b=T4uyAiybW5rVESdU4AGkHOvCDanC9qr56Rp8sYf91W4XBH/ASCR3Gse8qDH6Q/FQoQHQz3QO1VEbTmw9F4MJ+FsX+rqbksL459Ob91SoXmxLnd3QvjyzSM7AcsP+k9udSmNbgCGoq6nnhylRYPt2sYO6QjnKwgC2CU+lw99Sqplu9yiuFmozXPxIz+79LvtVTTrXy0NhWZU4+w3NPV95ElQTYwPoEQiCduyrgK9pXilBPpGDNXP/JstKhv3G4Dst7JRRrkoH1sLG8c+dghp3LCVauTuEKMhXtu7EDFCUKrkSYvlHC92EPuLzebJ6MRL23js8xFtTgBdKSY1uGldbKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6a0/wTlEEu0B9AUeycwlp/r1qlJqQTsW/PlMzgFcK+c=;
 b=B422JRZFAeyqpih3TKfcwP/vEEGPt3QSDnzOC1t86UJvyWzHuADUxEufU/o68/pD8U33Vu/oXeEp9sJWvBdH8dieYvmEypk3ZLrBIe5wJEPVWTgqNMbRFwDFGEoRrY2KyYBSgrc5LFpb1/Cc8RlV2uRom80IODs67jKM3pi4NJI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by MW4PR12MB5665.namprd12.prod.outlook.com (2603:10b6:303:187::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.16; Wed, 25 Jun
 2025 07:53:09 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%5]) with mapi id 15.20.8857.026; Wed, 25 Jun 2025
 07:53:08 +0000
Message-ID: <03dbaae4-df8c-49a9-b937-72a39b557d13@amd.com>
Date: Wed, 25 Jun 2025 09:53:04 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 06/11] drm/amdgpu: track the userq bo va for its obj
 management
To: Prike Liang <Prike.Liang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com
References: <20250624084535.1178476-1-Prike.Liang@amd.com>
 <20250624084535.1178476-6-Prike.Liang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20250624084535.1178476-6-Prike.Liang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0446.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c6::12) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|MW4PR12MB5665:EE_
X-MS-Office365-Filtering-Correlation-Id: 856645be-2ee0-4b6f-a519-08ddb3bd5348
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bk5aQmlBUndGa0dXQWd5dDA2M3pjR0lmSFdydzEwWitxNXoxTHpQS1VTQk9U?=
 =?utf-8?B?YW9ndHd3MnlhbEN6OUhCdmFHU2k0QWN0cUNEU3ovUlZGck1XWUQvQ1VjTWRP?=
 =?utf-8?B?NWZzcXg2emFQY1E3KzJDaUw1MW05dTBWMjBOeWoweHVxalNqTVl4eXNjOE5D?=
 =?utf-8?B?eHUxcCtyd25adzAyeWhiYUpiRnFyeEZSNXIwc2Z4ayt0Z3hyV2ZlOFptUXBN?=
 =?utf-8?B?TmlzRS9RL29UTFpKb2xxb2NoSVlKVk1wS3dDbDJ3RDhiU1dOM1BNY1RkeE4x?=
 =?utf-8?B?Ry9XNWRTOEFVcGRyK0REb0tOdXBFTUo4NG51YzNHeDhLSmZraFhGT1VmWkcw?=
 =?utf-8?B?dzRuaWJTcHRITmZCUGlLdCtUWmRYUWlPK25NRUQ4V1NlMWxxQkF1SkR3djl0?=
 =?utf-8?B?cUYwMGJpUXRHL1NwNW5pVmNHaDBuTTNneS91R3FHdHlzVkluZkZFQllTQWx1?=
 =?utf-8?B?akM5RDFYK1BGKzBnRDdoQ1hqV0lNbEhEcDdxZ2tSM3ZKdXJZeWJGdWI2aTZI?=
 =?utf-8?B?TDNOWDRqRnYzMHJtZ2NoUHlBamcrS2VtU2pmYitKWDg4QTZIWDhoMTc1aUl3?=
 =?utf-8?B?Z1hlb0FYTGtPUFRJdzBQeWVJdW80QVZtSHdUaUc5cWxiVmtnVDBUQktaR2xW?=
 =?utf-8?B?TzU3WG54aE9uUndBL0RXc0RYSHNGT2ZHS2RsVUJJS2VUMHl3NTJnckUwU1dI?=
 =?utf-8?B?dnVWcDBKaVBjYWJDZDVnVjJkSkx6cHVESTNpV2ZhZUEvd3lhQUZVU1IzM1NF?=
 =?utf-8?B?UTdFMUhGNU56T2o3V1U3WmZxT2ducnN0cHFCYlJnTUI2SklvdFNndWxXRHF2?=
 =?utf-8?B?cDFpcHloVVdSNStvdytuUklhNFZZMkY0a1FpeWFja1lFS2RxNi9nd0hhazRD?=
 =?utf-8?B?WlAyRmlBRVNZd1M1eHI3N3J6YnEzZE1UdDdkcUFPeTUvc1JzSjZQTXE3STRM?=
 =?utf-8?B?YVRub1FZZld2UTd4ckc1U0hyU0t3OUhmbEJ0TEkra2JEM1FlaFU2NnNURmRE?=
 =?utf-8?B?WVBMcE1IMy9pKzBQZzk1elg4L0NEdVE1Rzh0bjFjTzRXbjUvQ3JEek95UlV1?=
 =?utf-8?B?aENybDc4ZDR5bkZJTWZ3MFFLQlNFeldqZ1hrOVVCa080SE9DOHdCM0FvdGFr?=
 =?utf-8?B?RWxwTTNpM0ltcW1ySHhSWk5PTnhmNmJPVTM0RGpkWDRTUGMzbTZRaXF2aHVv?=
 =?utf-8?B?ckhDV2NhQUMyS0xVU211eDNSMkdmUGFOK0l4Q2NmcnV6cnZQU09qanVNVFFT?=
 =?utf-8?B?cjh3N1ZVY1A0ckJETGtQOGhIcnZMeDMrTGY0cVI3RGFkaUVpUkNuTm9DSkJl?=
 =?utf-8?B?ZGNZaEFaVnRiWDBRa2tsNS9mai9EUUxVTEhFSy9FOENuS2w4aTRUZ2JGMWcw?=
 =?utf-8?B?RUpuOGRLRGczZExzZzhPRTJtbjZDeE5qbWpIQjM1SGV0WEdUWTluZDlabmlw?=
 =?utf-8?B?K29RVkJqK3pqME5SNUNXalB1emRYdWpPRGh0UTVPbVlFS1hZUGxLRHpHQVpE?=
 =?utf-8?B?YkpIbHVHMEo0NVVuYks4RHNqbmlvclJzWmYrSE52SlV5aE95SUVRRWYvSlhv?=
 =?utf-8?B?eit5WUc5REtOUUxTZjJoemtlZVY4eDgrRHRsaGhaSTdaY1dmSkZHYVk1a1Z2?=
 =?utf-8?B?ZktuNVMvNW8rTHNIWnVkbElNQ1VhajMva1BnYzZOd2ZHcURhMlJ6VTNuR09v?=
 =?utf-8?B?Zll2UXV5eGQxY1N4bUZMaUh5bExaelljUUMyRDlYZHBEemViS3NqUnhqekov?=
 =?utf-8?B?VlI1aVQrbXNJdFVjL3RxRDNMTnBJY0JZa0RyVnhscnRwZFlXWWpRWVlVY2Qx?=
 =?utf-8?B?cDM1ZlkxRFNGVlJGM09QSVlmRU4zc1JIcmlnaW1IOTNOLytGanE2MFVJT1hL?=
 =?utf-8?B?YS8veFhKWkJUL1JhRnoxbkRBSkM1M3c4Wmw3ZTNuRUFLenNNVVM4bGZaV1R0?=
 =?utf-8?Q?LNT3RT05LLo=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bHJEMmV2blZiM0QxMUUwUjd6Kys2eFBwRTQzN09EeWhkWlJGWSt2SCtvZjk0?=
 =?utf-8?B?WU1EVWFKS2FrQmJaSXdrSVVEYjZ1ekxxRnlFbWJIc3pjdXhBMDdkTms0Y3h6?=
 =?utf-8?B?clpoWUp3RzdWei92YWFSSUQ0ZXFYM3VKK29sWi9uVmpHQ1RrQSt4OVFvUW5Z?=
 =?utf-8?B?dHcwQjRWU3BBVHJydFhISHZUbE1UQThQUFFDZjVyMzI0Q0J0Sm8yUnFFbDhS?=
 =?utf-8?B?am44Y2pUcDlRZ2xkK0pkc1VqaTR4dWVKRGt6Q1kxK28xVnpHWXVMa1YvWTRx?=
 =?utf-8?B?K3FtQkcrTFpZcWFhM3BRMVovOEEwbzBsSDgrekYyOTVydWVwT0R4YlNWcThZ?=
 =?utf-8?B?VE9TN3RQNGFqZVJPaTl5bnlCNFpOa1BkcnZsR1YvSlE4WkxZT0J4d3BmUmlv?=
 =?utf-8?B?dUFORWNVR0VQTTRvUHB0Y3BHN1ZFU1F6dVc2NFozU3VvUkZ3K2p5cExzc1o4?=
 =?utf-8?B?bXJ6cDdkeHVEVkVyVXZYUTNSZHlHcVNCbG9LMEkrNFB1QmsvYlNjOGJjYjQ3?=
 =?utf-8?B?SG1ncFRDTnJadjJWUGJsMXJKcVEvMVY4N0xuWWJuaHVCYjhZQXBTSkVFdy9u?=
 =?utf-8?B?T1kzS25NOTFudTVHcHd1T0g2MThSSzc0Z0RrWENqSWs4OVY1eDFwY0hId20x?=
 =?utf-8?B?dlJLckJrdG1IaGNzWWhLZ0t4aFJGTUNYLzdaUXU2dHFpNStydkxtaUJFaW9S?=
 =?utf-8?B?Zm1aNGoxeUNpd0dRWHRZTG5nUXBtdFpCTWFJNHAxZVM1MnlTVlYyL3FCWDQ5?=
 =?utf-8?B?NkxtRjNDc0xpaEdZeUhGWWJiREJUOURqalBldm1oUklsZER6enRKaHVKbVhD?=
 =?utf-8?B?MFV2Y2lpR1lDT0JNMG13cW5kamJ1dm5rUVpNRHc2V1F4SktsR0dQMVNCQ0lJ?=
 =?utf-8?B?RDA1M25DTlZHU2JNZG5NYUxYSUFyUXJoU1RKclFYekt5dFVzUERCYnJCV2xl?=
 =?utf-8?B?cWRHWkFHakNnSWlTRjdlNVRsTnVEQWlsbU1uWGxxUXRZSjRTY21TS09QRWFG?=
 =?utf-8?B?TGFHZ1EvVzZlOUx0K2haS2MrcjgzWllqVmhIek9ld3BvYTZ5WUhzcmtrNkQv?=
 =?utf-8?B?WDhxVjNsYjlFdm9qS2hkRDhNSWhmVzFDMVBhV1ZzSHBTS0ZiSzNkT1gxZVFC?=
 =?utf-8?B?NnRMUFpVYXM0QXdkKzF1emZ5NWNuSDE5TldvWXFMSU5XTVRrWEVmc01ITDMy?=
 =?utf-8?B?dWVVcVhKMVdwWi8zeUR5UmNQOSszZDVVVE12TmU0OHFPalFCem5Gdmt3RHNi?=
 =?utf-8?B?YXdHQUVFSkFrK2VoaUJROW82ZEhzMjJYNHdJM2hwRGRMdGxhWUhQL1NPMFFC?=
 =?utf-8?B?bmZlZUJnM1lqL2hFdWJuWTY0dE8vWlRTUWVPczFwUHk0aE5XK1dOK090VWVy?=
 =?utf-8?B?eUl3OE9TdGhKR1hwc2lzNzcxamRMcmR2b0pBTUEwUSswQmNoUWJrc0Y3OG8r?=
 =?utf-8?B?SWlRdEt4MXlMMDdJYURmbG5ZRkdxb1p2M1hPSGRiR2hMQzFGeVlqTm9lamQ1?=
 =?utf-8?B?TlJJckd4c3lqR0s1RmtsUWQ3bklwZ0ZSYVhiRmpleTFrZkpOZExqY21LU3p0?=
 =?utf-8?B?dktpczlCVGtSRzlUVDhvYzNpRGRwMnZxQUF1ZUZWdlNxUHF5ZjJJUHFZZENk?=
 =?utf-8?B?eWZPYm1tVEFPOUJwVVcxL1BucEJZZzRlWG5qRmJSZFcrOFcyQXRublJ6VWtY?=
 =?utf-8?B?bnhpTnlCTWNGQmFCRThzOENUbE05aG1VVlVZNVNJWHJsOXduK2JtL1NHazd5?=
 =?utf-8?B?MmRnaUFvQlh1eFVrNW5GMWx5d0F6NTRFaW1lMVNnWG5sZXF6YUhsU3loU3Qr?=
 =?utf-8?B?ZjcxVnVmcEVQUTl3MHBlZkJ1VGdSczF1S204RWtob2pVNFE3dTJzSncvSTN5?=
 =?utf-8?B?YTlTZkRBTlNkR0cxV21YWng0eXhlSHJ2OVpjaTRvWC8rbXo3RkFhZTBWQmZK?=
 =?utf-8?B?dUM0TVM2NTBqUnNZdE9LUlUvaHlJWEp2VmxUQ1EwTXdINVhHMU5yS2djSUsz?=
 =?utf-8?B?TmtIRUMyWW9oZkZiOCtLQVA1NmpCVVg5cmpJZDVXSURMZjU5UEVnRHhiL25K?=
 =?utf-8?B?TGpFSG5aUU1PWm8yaFFPbWZIdzRzRWNqMlVUZGJZbVRtOGlPMmZHVTJYQW5V?=
 =?utf-8?Q?VUyAjay7efx97nape/dUGO1UE?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 856645be-2ee0-4b6f-a519-08ddb3bd5348
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2025 07:53:08.5929 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: llO3PqFrGh1a5kMWx14J6yH23GJ3WKbddC+0TWrhZdh1xKKR2EyPF/I0504CAIwe
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5665
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

On 24.06.25 10:45, Prike Liang wrote:
> The user queue object destroy requires ensuring its
> VA has been unmapped prior to the queue being destroyed.
> Otherwise, the kernel driver should report an invalidated
> error to the user IOCLT request.

Well that is completely nonsense.

It must be just the other way around, you need to destroy the queue first and *then* unmap the VAs!

Regards,
Christian.

> 
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> index cbbd1860a69a..79b263c18eb1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -477,12 +477,24 @@ amdgpu_userq_destroy(struct drm_file *filp, int queue_id)
>  		amdgpu_bo_unpin(queue->db_obj.obj);
>  		amdgpu_bo_unreserve(queue->db_obj.obj);
>  	}
> +
> +	/*
> +	 * At this point the userq obj va should be unmapped,
> +	 * otherwise will return error to user.
> +	 */
> +	if (amdgpu_userq_buffer_vas_mapped(&fpriv->vm, queue)) {
> +		drm_warn(adev_to_drm(uq_mgr->adev), "the userq obj va shouldn't be mapped during destroying userq\n");
> +		r=  -EINVAL;
> +	}
> +
>  	r = amdgpu_userq_unmap_helper(uq_mgr, queue);
>  	/*TODO: It requires a reset for unmap error*/
>  	if (r != AMDGPU_USERQ_STATE_UNMAPPED) {
>  		drm_warn(adev_to_drm(uq_mgr->adev), "trying to destroy a HW mapping userq\n");
>  		r = -ETIMEDOUT;
>  	}
> +
> +	amdgpu_userq_buffer_vas_put(&fpriv->vm, queue);
>  	amdgpu_userq_cleanup(uq_mgr, queue, queue_id);
>  	mutex_unlock(&uq_mgr->userq_mutex);
>  
> @@ -603,6 +615,9 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
>  		goto unlock;
>  	}
>  
> +	/* refer to the userq objects vm bo*/
> +	amdgpu_userq_buffer_vas_get(queue->vm, queue);
> +
>  	qid = idr_alloc(&uq_mgr->userq_idr, queue, 1, AMDGPU_MAX_USERQ_COUNT, GFP_KERNEL);
>  	if (qid < 0) {
>  		drm_file_err(uq_mgr->file, "Failed to allocate a queue id\n");

