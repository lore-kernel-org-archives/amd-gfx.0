Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB03BF483E6
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Mar 2026 19:20:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 50EFA10E439;
	Mon, 23 Mar 2026 19:20:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="f215WwhJ";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012045.outbound.protection.outlook.com [52.101.48.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D100E10E439
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Mar 2026 19:19:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CEpzKcirc1vgqbQbXlb1G//towTTwOeWyeDwo6hTyx0r2PB1g8LCWEPdjlMyEMupzgt1Grl2N6/atCfWfcCEq1EI5wUQXZ1x103i3QNv2JNQHDFroEM9WoZY643nHs5pIEal+8YSJGUD6J0E0Z+cbI37waU7XoSIj1FNtvZn2BRCqgiRgQXZXW0NlwP4Ue96d8xfBKTj3Kw64/oZsdo3q9G7q1QbE70U+rg0sty2hiaLmVcqbzPtQnntNEbOsRqD2BJmUbS7FfYicoly5Y9TVDC6yqMsJeX+boUEPlDUeDiAtKa1r78zL+40+NzhinPOhzeE6PF6PYcbP7V+GDLD1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ema/5kE5VEuCMboOh3oK9GqYDWTZNttUdPZM8AoHGVY=;
 b=QmdTmqpWTl3uumFc3D6lpWrCdP26qsnQcO9Zk2Ac0fyFT2dC1J0Ey6d42WYgJl0OFJ3Oy9Zo7a3gfbB+nfNIspsNAvQr2zUCreVk4tOp2cS3x0wfRbhuW1wxG8AdHqayHxlwDEha87dM0u9WFon8gBJgNiu3/co5gdbPHk1/dQRHvrmgYNLY9oFProJotPDMO1wyRESvumMjergFhcyvaFIKKKTSUEdHdzvrgPwmnNYnnVjLOXezjW4g7KDrXHK5yfxY+FUIWVZZNR8WaMBslJCmkCW09TdXzfQcq/aMFUFKDMe0kROjjisAEsCn+Xz+G+Pmn2lhFQKZDQIl0zi8mA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ema/5kE5VEuCMboOh3oK9GqYDWTZNttUdPZM8AoHGVY=;
 b=f215WwhJyRfOugiaNGCk/l6Ed0cPRYu1r3aFgLI3Oe1Ugeo+A2p8MySCF9uo9wsGWzFCb1tFve/nltLabc5hkXAAp3oDbNgjQeGzo3Q57X+O4ef/fyG31n5mZ3oXqbQoN80zs9VBRWTvL1SzPt6z8A7mCS0BR8ZPrMhAZnaSTpA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH0PR12MB8464.namprd12.prod.outlook.com (2603:10b6:610:184::11)
 by IA0PR12MB8976.namprd12.prod.outlook.com (2603:10b6:208:485::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.9; Mon, 23 Mar
 2026 19:19:55 +0000
Received: from CH0PR12MB8464.namprd12.prod.outlook.com
 ([fe80::a45b:9b43:1014:eaf2]) by CH0PR12MB8464.namprd12.prod.outlook.com
 ([fe80::a45b:9b43:1014:eaf2%4]) with mapi id 15.20.9745.019; Mon, 23 Mar 2026
 19:19:55 +0000
Message-ID: <bbe58e02-2e17-444b-9de6-2619e6cd7897@amd.com>
Date: Mon, 23 Mar 2026 15:19:52 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/8] drm/amdgpu: Missing multi-XCC support in MES
To: Alex Deucher <alexdeucher@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, Shaoyun.Liu@amd.com, Michael.Chen@amd.com, 
 Jesse.Zhang@amd.com
References: <20260320200208.1188307-1-Amber.Lin@amd.com>
 <20260320200208.1188307-6-Amber.Lin@amd.com>
 <CADnq5_My31vVJVAmTiEAaS4nCeTC9fm_NXF5rO459kpmYP=dvg@mail.gmail.com>
Content-Language: en-US
From: Amber Lin <Amber.Lin@amd.com>
In-Reply-To: <CADnq5_My31vVJVAmTiEAaS4nCeTC9fm_NXF5rO459kpmYP=dvg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0140.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:e::13) To CH0PR12MB8464.namprd12.prod.outlook.com
 (2603:10b6:610:184::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR12MB8464:EE_|IA0PR12MB8976:EE_
X-MS-Office365-Filtering-Correlation-Id: 827bb4dd-0307-420d-929d-08de89112a36
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|56012099003|18002099003|22082099003; 
X-Microsoft-Antispam-Message-Info: XK0tse93nbIUONGDLCPFTw8R1SPkw8mOvn3q9MhJ5o87nsHELGo1DQ47bNyTOczyiX15XgJ29ER+adUsWVp4rthwMsIWOJSOW3RoXKMNrWKP0cF4cRPx1DHRJfJKfEKTMOVro5qqgzKlAMMmZZbdDTL8q9OkUxJqW7xawQTG2cRSUQBz5rjA+GCtIaA3kOREIBm3vH3RAABOqlSEPmSIrTQ5ORLU7y6zFMKXT/grs33jTitYlYOktUUVhAmndOzHMhwfwsrpDlRetG0d3zUSBGKPN7b3kx2UHt1Ko5R3ZfWhzGbskK4fEQEzFA/faBvUSHH590Z8yVec5mv6ozMHCBJb4Q/8qZMWho+jnIWhbHgpn5ttYKAYUKGlgly6idKqeEXVW7qx2YwanDKKbeUKBm+0Fs8n4Zqs7qF6q7bfgI7ZvVukVAIy3ZnEKl85asNSD3I9YUqII3OXSI2vdSAIBqf1SrfYChqN3Jr33VBZvyjMOuiV4yAyZtElvPYQ+YscSkA8k7fkpSmjxKx744lTilCveNTxhZ7ANaDrf2N7lqdDonyGPRHUUd7yfkY3mvw5HH44hwdMWxljoqYnqmv6lZwuTFxYtjEECbetEL/epTBCJ4m8oISvyFls+O1elOBruvgZUNKi/rBn0wMKv487D74indWdskZbXNhtm0bYjIc6YDOg1uUI9CiiFUGSaTJ2TpCPYc7c/564p9vo3a6Dq6RvXPJ8rLr4Lw1qW55q4P0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB8464.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OVUxenQxbWRaQmFpcVBDQ1RhaDhkZXFuTWRZL2tvbnlWZWVQS1o3SnVFRklW?=
 =?utf-8?B?S3FqU1VVandyYmJuaFZCQkFQY3RPR0NWVDM2bFRXd01EQTZVM2FXMjhkTlJy?=
 =?utf-8?B?SFJMVThLd28vT001c2JRREgzR0dnYVFBcGFuMGN2UGNUc0gzbzhxdjRpa2Jv?=
 =?utf-8?B?N1pVaXUybE5KUTAzUFQ2WGpraHNwZWpJbGpjYzZXSHI5NkhhN2drZkllT0h3?=
 =?utf-8?B?VGpNWlhZMGJqZDdSSmtOblRpWHgvd09Kd3piYktnWVphSzJDaUN2MXRqazZx?=
 =?utf-8?B?L1VFNDd5ejlsc3F1NW1WZnQ0V0lHNkczazhjWWwzb0ROMVpBRTBQUHFVVEF3?=
 =?utf-8?B?RmhzOWovejdIV3lqN2hQdkJ1UjdKMUJ0Yy9ISndKRm4zL1dhVm5GdHJuUmc3?=
 =?utf-8?B?am0xaSs4T09jSHoxMEdPblVwQ21ERFBxWElIQWhNWU5lMFpFQlVoUU9UdGJu?=
 =?utf-8?B?U2hUcTlpalVuS3p4TWRJQ3VSd1U2ck1VUkVOdWE3K1FxUTFVYVI2Y0tSRE9O?=
 =?utf-8?B?TVdZbUZzNFR3TmlPQkZlZ0s2QlVUOWNKYVZmVzZ0Rm1iTGhMcWFpSmpLTDhF?=
 =?utf-8?B?MU5iSlVMVnF6Q0krLzgrMFI3amxxVEkzV1k4NXVyb0JoRlVpNUZKMkZZTmZs?=
 =?utf-8?B?SUdFNG8yanIxRGVmNU9xNjJ6M1Y1Mk1BR1hjTVB0RksrWWo2SU1oWU5oVUZ2?=
 =?utf-8?B?ejZCdXpCaEJ4VVh3Yk1NeERUQm1Za0NGb2l0Witla1N4Z3pPaE5BMCt3MDU1?=
 =?utf-8?B?Y2xTa1crR2V1NEhOcERjdjE4Tnl1Ykl4bzM4QVArZU1PaTNia0w1TFlVL0lR?=
 =?utf-8?B?OWtWVnF0NG00aEJZWVZpeUFidFFYTmhUZVdWUmxHOUtMMzhwOVlJbE5ENmZz?=
 =?utf-8?B?MDQ0WTFYNFhNcUsxT1lVVzh4Z0c3N1ZRTEJkWm80eTFOeXZKc3p0ZFNwWE9s?=
 =?utf-8?B?RnVDVE9ZS2ZnaDhWZkxydXFNUnJqRC9zOFpad3F0YWlKaFlVMDBjK0lFVjE4?=
 =?utf-8?B?SDVYa3NYdUMrWUloNmszVmFrU3ZXZEZ1cUswa3JIMWMzWi9ZdER5MExrZU9k?=
 =?utf-8?B?c0FpSko2eVZhWVk5eENjV2VpMDVTV1lCcUx3L2RjbisrTm93SlMxVUtRWVVq?=
 =?utf-8?B?bENXVjR5emtKYTRaeW52ekcyaUJhUDNJY2FCaU8raWowQ3BIZEo3VkhmMEVW?=
 =?utf-8?B?NCsvSDRSbEtuZzJHdHlYdnN0cWVmVkp3UzV3NVNpVk4wRDFXbzh5STQ4K1c1?=
 =?utf-8?B?Y0JMWDNoNFdBSVJhUlFtOE9XdmJtRWJHaUN2WTZYbS8zRFYxWW5oZ1UycWxI?=
 =?utf-8?B?Ri9KY0liZldwT2NrRkMvWkd5cWNKWXdRak5ZYVlXMk1YRmw1eXpCRFc5NDBt?=
 =?utf-8?B?M1R6SEdNQTYvYkRxemVmaHJ1aEw3SHlxQXBkazRHVzJDMXg1WjA5UTZGeS9o?=
 =?utf-8?B?WXNGaHJvWUlkZHJDcXhVNjhyWCsyWGdoaENpR0gxYnlZVGsyNFFNL1pXQ0Uz?=
 =?utf-8?B?U3VGcHRCdzRxRUQ1WEh0Y013SFQ0K0MxZ3dmcFFiSXFDV3NuN0xEbjlRNkJR?=
 =?utf-8?B?RDlSU2JDRDd0VjhMOUtYZ050UldVQ2psaCtMTFN4MHRxRGtaMzdqdVl6QnFI?=
 =?utf-8?B?V0c4VzI2V0hRRGFLTk12WjJLd282cHpEQkJtMVBzOXZOVzRjcDd4QTZ5aS9W?=
 =?utf-8?B?U1YzWmhEdjZWTGgvMy9BZ2RMVEU2ZG9ITjF5dmpOaXdnd211SS9LZENNZ0tn?=
 =?utf-8?B?emJPR3hJTUVaYXljSTU4ZmVYcU9wQW5vQVpFOUJMMWgwRmtIb1duVU9jRVdU?=
 =?utf-8?B?OVdvU3ZBR1ZxdHlHdGZBWFFpT0F3TFcyM1h2eUt1MmtsTlAyNEwvK3hIbkFE?=
 =?utf-8?B?L1V2eU50cDBuRVdNditWdEtpTFFjQm9vaUJ4SXlwQmlZaytLbjZ4NWloYlJs?=
 =?utf-8?B?MlNDMDQrVHNFNlMwK2t4TDBWeGlJS3g2c05lcUR1T3IwUTJMcHlMN0FmSlFW?=
 =?utf-8?B?NCtGREp6UndxNmtMdGc4amd3MFZmWHlmNkI2UXpoajhMaVRzSjNzK1NHSWdG?=
 =?utf-8?B?RDA1dkJUTTR0OCs0R20wZ1VmRzVTb0wrUUVCemR0ZXhsMVJCV2plekMwY0VZ?=
 =?utf-8?B?Wm9JK0FGOTNqU1RxRmxUYkNXeWdOZWw2OFpZdjVsK0JhK2JzMmR6cGVDS0Zq?=
 =?utf-8?B?OVNPNzlzQ21iRzZ0OHNBSkQvYm5vclZaZ01nMStYMHdDR3N1alM2eG5BVU5O?=
 =?utf-8?B?bGNkVVdINTJoK09jL2RQU2dYVEtUVFhyVW14REExdytGNmJwYU1uK0tYd2po?=
 =?utf-8?Q?rg2m1fFqv7vEQcHgwt?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 827bb4dd-0307-420d-929d-08de89112a36
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB8464.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 19:19:55.0659 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UwSxEK5jxO3lOKc6YAygb1C0uYweApIH+kATQUx4RPIXQX0Pfcn+k7MW5VBuVcDt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8976
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


On 3/23/26 15:10, Alex Deucher wrote:
> On Fri, Mar 20, 2026 at 5:19 PM Amber Lin <Amber.Lin@amd.com> wrote:
>> In a multi-XCC GPU, pass the master XCC's ID to amdgpu_mes_suspend,
>> amdgpu_mes_resume, and detect_and_reset_hung_queues so the command will be
>> sent to the matching master MES when the compute partition mode is not
>> SPX.
>>
>> Signed-off-by: Amber Lin <Amber.Lin@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c            |  7 +++++--
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h            |  9 +++++----
>>   drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c             |  2 +-
>>   drivers/gpu/drm/amd/amdgpu/mes_userqueue.c         |  2 +-
>>   drivers/gpu/drm/amd/amdgpu/mes_v12_1.c             | 14 +-------------
>>   .../gpu/drm/amd/amdkfd/kfd_device_queue_manager.c  |  4 ++--
>>   6 files changed, 15 insertions(+), 23 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
>> index 710bca87c32b..4f44b933e373 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
>> @@ -300,7 +300,7 @@ void amdgpu_mes_fini(struct amdgpu_device *adev)
>>          mutex_destroy(&adev->mes.mutex_hidden);
>>   }
>>
>> -int amdgpu_mes_suspend(struct amdgpu_device *adev)
>> +int amdgpu_mes_suspend(struct amdgpu_device *adev, uint32_t xcc_id)
>>   {
>>          struct mes_suspend_gang_input input;
>>          int r;
>> @@ -310,6 +310,7 @@ int amdgpu_mes_suspend(struct amdgpu_device *adev)
>>
>>          memset(&input, 0x0, sizeof(struct mes_suspend_gang_input));
>>          input.suspend_all_gangs = 1;
>> +       input.xcc_id = xcc_id;
>>
>>          /*
>>           * Avoid taking any other locks under MES lock to avoid circular
>> @@ -324,7 +325,7 @@ int amdgpu_mes_suspend(struct amdgpu_device *adev)
>>          return r;
>>   }
>>
>> -int amdgpu_mes_resume(struct amdgpu_device *adev)
>> +int amdgpu_mes_resume(struct amdgpu_device *adev, uint32_t xcc_id)
>>   {
>>          struct mes_resume_gang_input input;
>>          int r;
>> @@ -334,6 +335,7 @@ int amdgpu_mes_resume(struct amdgpu_device *adev)
>>
>>          memset(&input, 0x0, sizeof(struct mes_resume_gang_input));
>>          input.resume_all_gangs = 1;
>> +       input.xcc_id = xcc_id;
>>
>>          /*
>>           * Avoid taking any other locks under MES lock to avoid circular
>> @@ -462,6 +464,7 @@ int amdgpu_mes_detect_and_reset_hung_queues(struct amdgpu_device *adev,
>>                  adev->mes.hung_queue_db_array_size * sizeof(u32));
>>          input.queue_type = queue_type;
>>          input.detect_only = detect_only;
>> +       input.xcc_id = xcc_id;
>>
>>          r = adev->mes.funcs->detect_and_reset_hung_queues(&adev->mes,
>>                                                            &input);
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
>> index 2e6ae9f84db0..643b4f8d757a 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
>> @@ -325,8 +325,9 @@ struct mes_reset_queue_input {
>>   };
>>
>>   struct mes_detect_and_reset_queue_input {
>> -       uint32_t                           queue_type;
>> -       bool                               detect_only;
>> +       uint32_t        queue_type;
>> +       bool            detect_only;
>> +       uint32_t        xcc_id;
>>   };
>>
>>   struct mes_inv_tlbs_pasid_input {
>> @@ -442,8 +443,8 @@ int amdgpu_mes_init_microcode(struct amdgpu_device *adev, int pipe);
>>   int amdgpu_mes_init(struct amdgpu_device *adev);
>>   void amdgpu_mes_fini(struct amdgpu_device *adev);
>>
>> -int amdgpu_mes_suspend(struct amdgpu_device *adev);
>> -int amdgpu_mes_resume(struct amdgpu_device *adev);
>> +int amdgpu_mes_suspend(struct amdgpu_device *adev, uint32_t xcc_id);
>> +int amdgpu_mes_resume(struct amdgpu_device *adev, uint32_t xcc_id);
>>
>>   int amdgpu_mes_map_legacy_queue(struct amdgpu_device *adev,
>>                                  struct amdgpu_ring *ring, uint32_t xcc_id);
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>> index 78d1f3eb522e..35734d34763a 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>> @@ -5200,7 +5200,7 @@ static int gfx_v11_0_post_soft_reset(struct amdgpu_ip_block *ip_block)
>>          /**
>>           * GFX soft reset will impact MES, need resume MES when do GFX soft reset
>>           */
>> -       return amdgpu_mes_resume(adev);
>> +       return amdgpu_mes_resume(adev, 0);
>>   }
>>
>>   static uint64_t gfx_v11_0_get_gpu_clock_counter(struct amdgpu_device *adev)
>> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
>> index 9508709abd49..d02a84711394 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
>> @@ -266,7 +266,7 @@ static int mes_userq_detect_and_reset(struct amdgpu_device *adev,
>>
>>          if (found_hung_queue) {
>>                  /* Resume scheduling after hang recovery */
>> -               r = amdgpu_mes_resume(adev);
>> +               r = amdgpu_mes_resume(adev, input.xcc_id);
>>          }
>>
>>          return r;
>> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c b/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
>> index 70d80c2aed52..4b279259b9d3 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
>> @@ -1888,24 +1888,12 @@ static int mes_v12_1_hw_fini(struct amdgpu_ip_block *ip_block)
>>
>>   static int mes_v12_1_suspend(struct amdgpu_ip_block *ip_block)
>>   {
>> -       int r;
>> -
>> -       r = amdgpu_mes_suspend(ip_block->adev);
>> -       if (r)
>> -               return r;
>> -
>>          return mes_v12_1_hw_fini(ip_block);
>>   }
>>
>>   static int mes_v12_1_resume(struct amdgpu_ip_block *ip_block)
>>   {
>> -       int r;
>> -
>> -       r = mes_v12_1_hw_init(ip_block);
>> -       if (r)
>> -               return r;
>> -
>> -       return amdgpu_mes_resume(ip_block->adev);
>> +       return mes_v12_1_hw_init(ip_block);
> These changes seem unrelated.  Should these hunks be a separate patch?
>
> Alex
Yes I'll separate them into another patch
>>   }
>>
>>   static int mes_v12_1_early_init(struct amdgpu_ip_block *ip_block)
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
>> index 18bc5ba25f8f..ec8d7f4be840 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
>> @@ -367,7 +367,7 @@ static int suspend_all_queues_mes(struct device_queue_manager *dqm)
>>          if (!down_read_trylock(&adev->reset_domain->sem))
>>                  return -EIO;
>>
>> -       r = amdgpu_mes_suspend(adev);
>> +       r = amdgpu_mes_suspend(adev, ffs(dqm->dev->xcc_mask) - 1);
>>          up_read(&adev->reset_domain->sem);
>>
>>          if (r) {
>> @@ -387,7 +387,7 @@ static int resume_all_queues_mes(struct device_queue_manager *dqm)
>>          if (!down_read_trylock(&adev->reset_domain->sem))
>>                  return -EIO;
>>
>> -       r = amdgpu_mes_resume(adev);
>> +       r = amdgpu_mes_resume(adev, ffs(dqm->dev->xcc_mask) - 1);
>>          up_read(&adev->reset_domain->sem);
>>
>>          if (r) {
>> --
>> 2.43.0
>>

