Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C93A7C87FCA
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Aug 2025 13:29:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 77E2C10E84F;
	Thu,  7 Aug 2025 13:29:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="NboeHnXm";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2051.outbound.protection.outlook.com [40.107.220.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D5FA910E84F
 for <amd-gfx@lists.freedesktop.org>; Thu,  7 Aug 2025 13:29:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yk9wJYjAsXBdbbIR+oPSd+0v5oTdIhuJXnTbSgW12Uexkmf94LYnEtB+pDkuR/w7VaevNfvfddkC0nTic+Qrrad31r5ZUXWvbBx5sr/OxeQ9rrrH1TaN+0xOvr53QS3FMKmkke/4PNpCkf1BqCitVyOCOiRw4gB3I7rkU9YkTFDkB5V4rFiVINuIeMWWLi8N/BRO9kBZua7MLrHN8jrQ3dPBxqZ2oolvRf5x3Q9MOqQTkNJVPgZORhnS6gEjIHQEZKe3ufhV7RSYpm9oXcapdeZzNWT9mUyXUbQkmxANSZQVXavIsBEMBWunZEk6o9RehknS1V8/9PRJWPwPvy/XUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aMJ9c+SCLDdoERLGvCBTgQOPw2A5EM2TLh+1hqg+dTc=;
 b=eSejf9feA07UKXNxuhqPsVdhq81kfpX208QH3+7tdH5LrAYoLL5oydQUXq6zUkiON8P0JTq5zVq7+KhuW9/wA7/wZ/fK56bQDbRzkwtklDVjylS5dGt7UHCx80N79u0nptObQGP+r/lKyO4RuE3k6jze/E1k81E66U2kRTiAeIHXxWPdpD+4uyQtdq+EvSKOky1jscl9kVSx3j8g0HJcC7/RQqs8KI2mkmmAZ01Lu17O2HnDV/JvHkKIyTdUPQasTPIXIQD5Ba3ueMoD8BG791sTfwAra3AsN2OjRLzN4LSh0+S9sCO3QV2c17uNrPNBioqu3I1i6U+BMn6QLwcaew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aMJ9c+SCLDdoERLGvCBTgQOPw2A5EM2TLh+1hqg+dTc=;
 b=NboeHnXmPKzZLQOayhUGSrlbHeYNuOQd1Ip07Hao6RuMPq8gc0TO38RRTc53GmRfusLzwzMji/H4iNArKwUFkBs1HvtjaqoBfbscMqR/uiZfIazywSNWmeIjz3OwX+Cw3C5L4OZ3beh1VUiwuB6BRxePHkjYRUbvZQDNFa3ydDo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by PH8PR12MB7160.namprd12.prod.outlook.com (2603:10b6:510:228::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.13; Thu, 7 Aug
 2025 13:29:48 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%5]) with mapi id 15.20.8989.018; Thu, 7 Aug 2025
 13:29:48 +0000
Message-ID: <9c56c638-a0d8-4f9e-b865-83ef6a124de3@amd.com>
Date: Thu, 7 Aug 2025 15:29:44 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: Is amdgpu open to converting logging to drm_* functions
To: Alex Deucher <alexdeucher@gmail.com>, Brahmajit Das <listout@listout.xyz>
Cc: alexander.deucher@amd.com, sean@poorly.run, amd-gfx@lists.freedesktop.org
References: <hzobspwqosrmrdmzicwabpsr4lcisuwck5nfsh5qwkoek562to@ybja5yzucsbh>
 <CADnq5_O1PyEqtK-GGPgPzkMDeNmTCFFNDLd-+73NDqFtPVL2oA@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <CADnq5_O1PyEqtK-GGPgPzkMDeNmTCFFNDLd-+73NDqFtPVL2oA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN0PR03CA0030.namprd03.prod.outlook.com
 (2603:10b6:208:52f::19) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|PH8PR12MB7160:EE_
X-MS-Office365-Filtering-Correlation-Id: 1469e236-87e5-4617-1bf5-08ddd5b67b13
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UjMvakFkSnMxWFJwbXpNa0R0dnNhSkR4RE9peEFENFRJSFVTKzRSbDNrTFZK?=
 =?utf-8?B?Z1NqU3VoZGl2S3RlQWFDeUVyRnhwMXZaMjFoTGpiZk02cXVTVVFld1pwMm4w?=
 =?utf-8?B?dFdxZ0lzY21IdVI4SnpoMjM0eDRaRUtjN3NlOEYvNk1nMFlLRUQwYm12UmZG?=
 =?utf-8?B?VjVxNjZRUkRJSlV6bFI0Yy9maEloUHFQRFg0dm1FbG9XZFRtNS92L3JmTUNX?=
 =?utf-8?B?NnU5OEY1Vk8veWIzbWRicU5iWmZ2V0ZxRUhYZDlodFUwamJuK2VTS1pteDEx?=
 =?utf-8?B?UVhhREVwc1JkeU9jM09EOEI5dXVSREwzdjVURDFUMVQ1eC9Zc0tZWEVGMEI4?=
 =?utf-8?B?Ui83S1VDeHJBeGFXNDlSVXJ2RlYzejFKM3NRRmhCNy96NHNlY2l0QkxSV3g1?=
 =?utf-8?B?NnhGT3RLL283dWV1YlAzNlVHKzBGQUlUb2JWT0YyR1hjOVdMZnpRUTRmVk5T?=
 =?utf-8?B?RTdqZTUxVE02SGg3ays0d0xyRHM0UlpWYnN0d3BrSDR1QmVzTGZPZ05vNjdm?=
 =?utf-8?B?NFBSQmc3ZzdwbzYxQ2YxRjRxd1Y4eFBNY1ltVVBCakpqelp3UXBndjJ1cUkr?=
 =?utf-8?B?cjZ5eTdES1UxVnl1Y3ZnSjZvakkzejBlSUVFU2NjQ0orRkJscGxGQUpkMjNK?=
 =?utf-8?B?K0FQZWFFdEpmWjBPbi9vL09NSDE5SmJSbndLd3hrQ2M4TWx6SzE1bEpHTnZj?=
 =?utf-8?B?WkJ0V2Z3NGc5N2t1djl6d0kzaTAzMVAvRmJIcVdHdnRLZDl4YWo2VHh5OURY?=
 =?utf-8?B?bnA1YjBtZm5YSHNBcXBYT29VQVRPZlgySkp5c0NoSEQ2MlN3Rm1MVWk0b1da?=
 =?utf-8?B?VEFIZDh2UC8rQUU2SjQ3clU3OURBZ0dvU0ZXWWdMZlNwUEw1U29LdlFuYzZu?=
 =?utf-8?B?K0xMWEZ1T2pYQkZZaFlveHpDZ3BXM2I2NU02TU5ndlBTWUpTV0NiOUo4Vjl4?=
 =?utf-8?B?aDFVb1NSSndYaXQ4UDdvMTdld0U4TFArSUVLem5Wd2VYU3Y3ZDMrVDB6ODNt?=
 =?utf-8?B?VUs3cXJKc1lSVXJvTXJGbnBHWnpxTUt0NGUrT2tCSmh2blBjcXFUSjNma0Rn?=
 =?utf-8?B?YTVFMm94QysrVWJYSFVQSStrTkRJRjZkNytPdis4TWR3Z0tCM2d6dXk3d2lN?=
 =?utf-8?B?NVEwMnljTjNYV2o2c09QSkVGdmp0Y0o2dEpRRXhJT2JlZXhGVGNSWWFBOG9B?=
 =?utf-8?B?L0FUK1EwRW81SnY4WU04RWtrYVBaTDQ1N3dkbFpTOW43VDZ0bmNBb1pVYTV1?=
 =?utf-8?B?dUcrNHJkV053NHJjRmVTdXZHekhnN3poOFdaLzE2amhlRGVVSlZVcE5WbFJ2?=
 =?utf-8?B?MHNsVFdyQndsQnR4UzdydXdNV1ZtdGJBZzdQVXlqVHdlUTJjWDRvcTdyQUhJ?=
 =?utf-8?B?Q2NYa2tnSXI0ektPL3g4TXIxRlpUb0hVZEZRUmhvdjhmQytmK3RvVkhTSktu?=
 =?utf-8?B?MzhHR2crMjA0R2dTYzdGUFloR1pXeXVwUVV2ZkJLRkNHK2tJcisvdTNNUnV1?=
 =?utf-8?B?T244YnpwbmV3TWVUT2lXc3NQL2hLd2dhQXR5ZXB4bHM4RTVJK2dNUmE4d3RU?=
 =?utf-8?B?c0VXVkZTR0xGSUhaVktIYWxZWjFEK0o3eE9TVkhidFI3L3lISndVNHFBNjV6?=
 =?utf-8?B?Q2puTnJqbFpUVzB3aU80Q2ZlWW1kSmUrTy9Uam1OSDJaRTJ3ckNIVFhiZkx0?=
 =?utf-8?B?WFhhWjd2T1liQkc3aFJ5RTJOSzJNMWk2WlJOS0pWVkp3VDJBaGR1OG10RVc0?=
 =?utf-8?B?YlEyVjczZ1M2ejUyT2dkcDhhcjZtWW52U0RMSUlrYzYva2tYQmNmZU1CcTA3?=
 =?utf-8?Q?ZzmWsXFgoHTTgA3Adz0YMoWCCHTohvDUc7iNQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eFN0MFI4Rk9hQy9YOElvZmZWdmpPUldBNUdZZmp3U2tORzRCUG94RFExU0tY?=
 =?utf-8?B?Tk1yRjB2OXNKbFRPdGV0OTdIeExnZ1RiMXorVzdrQUgzZjR2VGNBYmZqOUx2?=
 =?utf-8?B?MzllZEpUbDBlY054Rko5OWRQNERJMkJiTnMxelB3SDAvL3FZSkRubkszeVBi?=
 =?utf-8?B?c1c2d3NCcEVnNmkydzYyTzN6TCsxVnUxeFUwSG1DVm9IWDY3Z0x1UktXWThG?=
 =?utf-8?B?V0pNNUJDY2RkNTlYNnBWck82M3VjZFVmQTJWdFZWOE1xRC93djJRVzRHakNC?=
 =?utf-8?B?TUxuYk9hRnQ0T3pHWVhTTmlkR2hTUExPN3BkaG5iYTNRaCtveEVOeFNXUXBw?=
 =?utf-8?B?WXV5Wi9Cak15Zjg5WWc0bEY5ZFViM1RsOUNkNVU0OWFVaVZyNkc1cWNvRHY2?=
 =?utf-8?B?ZXozRzBpQldvVmVVL3J5cGtqa1d5Ky9yandibjJ1YkExZlV3cHJnUTZ4Vzln?=
 =?utf-8?B?ZnlzYkNZUDBEeWdwODc2b0daMnY2cW9KVjF6eHZ4SVVSQTBMMi9GSzhuNUR3?=
 =?utf-8?B?WjlvbWFySjN4UmtLbFV4czJOcFd5Rkg3a1I5UzB1ZlhWOGRYNVJDdUtEc1Zu?=
 =?utf-8?B?TXNXanQ1K3RvczBRVFlsa2NGMkw4Zm1SMFhoTHZ1cG13MEdBNkJtZTJHYVo1?=
 =?utf-8?B?UnZyRkpaVjVNUm5wRGVYNFdTelRQUThEUDBOelg5ckdpOTVpMkVldDVhOXhD?=
 =?utf-8?B?UHlxSDZ2cWRjYUNjV2tIc3J3NHNrMCtQRkxCTmdaOTd2UUl4MGdxUHBJSjhE?=
 =?utf-8?B?YTAyRkQ1ZjJoaFZ3SUlyaE9ITjUrbTZuSzlCaExMelFOUnNaN3lTVDlKcmIz?=
 =?utf-8?B?Sm9iR3JlMmFsOG9CWkZzTEROZFRDS1lCalJtS2l0U0wrMzMyMWNHTnFVY3Ja?=
 =?utf-8?B?Z2lKeGh2bUV2dXJsVUp4eEt3b1RGUC80b0V5WDdGYzFCaFZZS3BWOGZqWXlC?=
 =?utf-8?B?UlU1NERRZHk0OUEwbWZkV05iMCsrWis4LzZCRUNqNXdaLzUwTk1lbWZIRnlV?=
 =?utf-8?B?L2Y3R2V1QS92cy9nYVl1Zktza3pYeWVsSTFzeG1uUGJ6c081UitueEwrdW5V?=
 =?utf-8?B?NjEzcFVUWS9sREplL1NXRWxTSXZHWmFkcGdpWDhVUHZ6TmU0SXAxbktXRWVR?=
 =?utf-8?B?cmN0TVZSZ3lRUm1TcUV2cjQ2UzUyemMwYXZDSlN2VVoveHVSaW1HVjdFeDdR?=
 =?utf-8?B?YjBuck5jM2hUWCswOEtOUWc3blBVdS9RMi9nZGREazkxb1pXZ2tETmhxakRx?=
 =?utf-8?B?UWZoU1FheUlkb0JvbldMait0UWFQZ1pHa21nZHlkVTVrMHNNZ3JHQTdhU3Ew?=
 =?utf-8?B?TWRlYmFJRFNIWUNzZW83d1orcXJKbEhQZGNUZmsxQmxJdit0MEw0MTMxczA0?=
 =?utf-8?B?Wk5qVUpxMDVub2hVRUZFTHltUGtyTEtOWUhwZklzNTRxQ0xNd29UeklvazZP?=
 =?utf-8?B?SFkzeEN1dFh5eEIvNmNkY29ySksxcWpZVExOdndwYWRXbFFHZlhubzNQRHFi?=
 =?utf-8?B?Ly85UlFnL0k5WWtEY2czdlJSTWZ5K3V5d0xkL1UzeG9iK2F4ckxXU1ZmUHVv?=
 =?utf-8?B?ZDVhRzRCMjhjZm9uS3lBZVhmN0FwUXZXVXVhSTU2bFhTQ25XeWhMMDRJMklM?=
 =?utf-8?B?d0I2R1pzaktOY3VjTko5TFJ2NjdFam9Hck9LOExWTnlCcXBRenI5M2dOTmRa?=
 =?utf-8?B?ZHNBNlA0NEx0azVMeTlLdkhKa0JVN3d3WVpSZTJOcUgvZkQ2Z09udnRpWkpX?=
 =?utf-8?B?endGN2t3NzFBUUZRRkVuRFZpMWlGU1Z5Y3hiNGc5dllHYjE3TXlSWlZyK1hl?=
 =?utf-8?B?bEQ3ak92QndpN3d6ZDBsS0I4WEtFalJxR0x3VTFvRTdyQXpPN3V1ZDkrUXdL?=
 =?utf-8?B?VEpmeGhHUVVCNkVpYWMwcnVVbUVXbnFQcVptUkF4TjNSanVCNkFoVEJGZHRu?=
 =?utf-8?B?SWIxdEZSWjJBRXZtOGRyS01HYnU0Unh5R1JxT2drdnc2ZHVib1Z1NjVYK3ZC?=
 =?utf-8?B?b1VETFNTMkJFcHVlb1B6NDdQUFhQbFdrVHF3V2pRcXBvSFd2SDZMckNoaUJa?=
 =?utf-8?B?MnZBK21xbyt2c2VMM1lhQ2l6RFlXd3lFZDZNWFQzeUNFM1VBUVJ5Q1NndnpM?=
 =?utf-8?Q?zmb9wWIiUz6vaoXu3gtnDWds1?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1469e236-87e5-4617-1bf5-08ddd5b67b13
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2025 13:29:48.4431 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3UZvPQ+aqBAgLNXuqX4YZ6XUb4Q5AVog6o8sKdr+YUMYHN9b9V9nZj9lTcOSYEKS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7160
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

On 07.08.25 15:22, Alex Deucher wrote:
> On Thu, Aug 7, 2025 at 9:13 AM Brahmajit Das <listout@listout.xyz> wrote:
>>
>> Hello Alex, Christian,
>>
>> I'm a mentee at Linux kernel Bug Fixing Summer 2025. I came across the
>> TODO list on the kernel doc, and specifically this section[0]. Would
>> amdgpu be open to this conversion. I saw that before starting it is
>> recommended to talk with Sean and the relevant maintainer. Hence I'm
>> emailing you folks.
> 
> It would be nice to get rid of the old DRM_INFO/ERROR/DEBUG macros and
> replace them with the dev_ or drm_ replacements.

Good point.

For the background, the old DRM_INFO/ERROR/DEBUG macros only printed a message without noting from which device it came from.

That made sense when you only had a single VGA graphics card in the system, but those days are long gone and today when we have a system with multiple graphics device we sometimes wonder where a message came from.

On the other hand if you just seek for something todo Alex and I can potentially come up with some cleanup work or maybe you could write some test cases or whatever.

Christian.

> 
> Alex
> 
>>
>> I guess you can also refer to this,
>> https://patchwork.freedesktop.org/patch/msgid/20191219161722.2779994-1-daniel.vetter@ffwll.ch
>>
>> [0]:
>> https://docs.kernel.org/gpu/todo.html#convert-logging-to-drm-functions-with-drm-device-parameter
>>
>> --
>> Regards,
>> listout

