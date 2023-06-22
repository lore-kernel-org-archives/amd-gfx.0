Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8539FEB64D8
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Jun 2023 15:04:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3695F10E577;
	Thu, 22 Jun 2023 15:04:48 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2056.outbound.protection.outlook.com [40.107.244.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C1A2610E577
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Jun 2023 15:04:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lrrh7F+2kZsVpV46AOPFxTBKGe1hHqYIk6AdXhb/9FrsNSWscHLC1tAqLUBCSUcgSa65fN2w6UTVDrWO5WeM13uWhcYWN7A8LdYrRS1A7OI0Foj6hOJPzbUjMfQINIKilSlvHZvSRQ0XE9Uxc1mbnYrn47yDsY4RHQC+opqzm2fd2Yvcx8DeGb5sWMyZBVJxkyet23WrAsOmUbe6g/r2Ou8LEojUjgB/Vd1a+q6XuaZCXtvJ9TAP3ijDv391hN96XYqG1crvadya8XuXB0WDUMsdiR36R1PRVgvnJtA3tZEaPqDUEN41wIHmj1YcKMDUSoCZYRN6bui/8zcGaEMjmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FYhxX5ZE3Id5di4+xlvNSR62MIek40hZj7HlH44jYDs=;
 b=XfRAjIc2r9izaQQ5n4A8oKisNJULm/6QXJfwNFthqrcYX+xie7JumnXNHf8QthpgZnqjaKkHxT76MNgxOXXAxxYhtnJZk1/p3WUk2wFLoamyZA/N95nSBRiLwtYh/kxTW5qqrl8tqLMnAqyUDFPKTUmTaM+8ia2ZHsm+BFjHcOGfrQyf6yPLwKVbdgXfBynv18I941HaVzmY+M6XxSdQPaSou0V12HDd2AjHcl8KQryEP/qX/zHwUwI8MpnzAnr/t4eBlyA634mn+ovWmhnWE1AxEU4UbZiBSIwIgy0EwxmQYqwhODoMnEH0787TFJfNTeP0tuV2QsgLIuaJA/nuiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FYhxX5ZE3Id5di4+xlvNSR62MIek40hZj7HlH44jYDs=;
 b=eXJuqvOTjXnf6zmSjx6brqkhWkBGngOmtgsOeC4akcHqdppbfcEjYLKRnDbglZFCcRRdZPSIKPN1+DexJhul4qE4lKWCp++4NZp4jrRfjMHIaGesLdL/OP2UbNi5Ye2k2T/p+B/kbrslcY1CPh/PCM0KVWsIrmM3sgeB0QYxCmc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB2941.namprd12.prod.outlook.com (2603:10b6:208:a9::12)
 by DM8PR12MB5416.namprd12.prod.outlook.com (2603:10b6:8:28::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Thu, 22 Jun
 2023 15:04:43 +0000
Received: from MN2PR12MB2941.namprd12.prod.outlook.com
 ([fe80::8c06:c9e:c6c2:3b16]) by MN2PR12MB2941.namprd12.prod.outlook.com
 ([fe80::8c06:c9e:c6c2:3b16%5]) with mapi id 15.20.6521.024; Thu, 22 Jun 2023
 15:04:43 +0000
Message-ID: <d515f44b-b149-1404-db5d-ee373e4ceb3c@amd.com>
Date: Thu, 22 Jun 2023 09:04:40 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] drm/amd/display: Remove spaces before tabs in
 amdgpu_dm_hdcp.c
Content-Language: en-US
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>
References: <20230622110037.1091075-1-srinivasan.shanmugam@amd.com>
From: Rodrigo Siqueira Jordao <Rodrigo.Siqueira@amd.com>
In-Reply-To: <20230622110037.1091075-1-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN7PR02CA0004.namprd02.prod.outlook.com
 (2603:10b6:408:20::17) To MN2PR12MB2941.namprd12.prod.outlook.com
 (2603:10b6:208:a9::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB2941:EE_|DM8PR12MB5416:EE_
X-MS-Office365-Filtering-Correlation-Id: 52f6833f-eed9-43a2-7d0f-08db73320258
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9xFnDpjd+JDJsR41K2ov39W1Pz5KXklKMuIe82njCC/AaJuF8w5TZ+Zbczmkt0k4R3R3l1e8Fk6rwkqL+YblOrrIynLvls4M9s3QFDr7ybGpgLWjjkTeXkzcOpOxdQfUd1qv8ng9BH6z2+56+pstfqdyDYkwXhxfKsyKYMMEidmAec83LhPy5tOOV8OtzbA+ivSGDmqUmXAkJl9Icz08+dQoBqpzPe/oGlVI1DoetUSo9titx37DGa6O1PIRDYeXqDKBjBJ9yReG8PkgHFfy7NFOnBZtvXvGpxC/VSJuarwPUeKyeALUADTQcgQqQtncHYER6FpNgIyLPk+d5M+cADmvJXN1j7vm5yvJxjZWI0WvFtPABNnQ8cNTJoZkLdOATAlABX6WlwfbIbv2IWYkZICN3J05wK+36MQoBhKAKV5xp4c0knGBHk1uFwFpwD5d4B8kA/xPOjU22+DiaV1kogeSjs7ucE67K6R5bMOUniYeEgMlXpelfE4kVmDNCi0FEL3PBANHe3ky52Crco+1q1CmRcw44/6ghZOLFh2GO1h6oPr8b4GMGomVbQYXpuY8QmLRJJaUrrmWl8BDtnxdvilGzHEvQPQt+f4FsKJJ9PKlQtc5cloWwotMHEZe9mwI8NiT9zrGDpQrdrCy15H68A==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB2941.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(376002)(39860400002)(366004)(136003)(346002)(451199021)(53546011)(6486002)(478600001)(110136005)(6512007)(2906002)(66946007)(186003)(31696002)(8676002)(66476007)(316002)(6636002)(4326008)(8936002)(5660300002)(66556008)(41300700001)(38100700002)(6506007)(86362001)(36756003)(83380400001)(2616005)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V0NFMDI4N3NleFEyeW1sb1RaRG5jOEdETmpCQm5rMHl6SmhRRi95UEhIbEZl?=
 =?utf-8?B?WTVMc25Rdk4vdCtqSE5FUTUyelh3Y1FuOUthbVVVQjlYdDlDUjdjYmhBZ3J5?=
 =?utf-8?B?dkdOVzN0RXowWWFxdGtYSjQyNmE0cGlLdFFBSE1lM2dKc1RyRHRVZitmRmNO?=
 =?utf-8?B?VExaNEtDNnYyb0FPaGFFZEFYS0RvRlRlZFBBT3pkbkpJRW9XZHVXakh1ZS9I?=
 =?utf-8?B?TGhJSGVWYVdhVmVOdzhZczlpenJQaUhPM2lobnZ0NGprWTYyNjZnK0ZrRXU5?=
 =?utf-8?B?QXpCVXl4ZmNuVThzb2tadzNKa0w4VUtWVHRYMVhDcGE4QldGQU5FTWZ0YnB6?=
 =?utf-8?B?Wkhyd2M0bWxTRjBzS0h3K1pnaFpBNVR6eVZGWEJRNk9Gbk1vT2U0MUtVajRj?=
 =?utf-8?B?enR5MmZseDdmdFdza09CU2J6YVBBT0VVeXRaRVNrSXRGV2xQS3doV0tFeXdC?=
 =?utf-8?B?MlBVakVQZFJpUnJSSU84eXlFb3JVckw0Skw3eVZEZWtheXEzVkpscHJwTk1h?=
 =?utf-8?B?Sk8rZ3FVQjRIcE1zWHJpSld1V2l4dFZKY0N4Wk5tZEIrRXJyczBiNzc4MXFG?=
 =?utf-8?B?cGVpME1kNTh2eGhIUXdtem5DZE9VL0d0STFNSkhvVWZjcHgxWE55MU9VLzMy?=
 =?utf-8?B?K0YzRFBGdHh1bkV1TXd6K2sxYitnNXhHYjcydFZKMUI1T0lpc29GenpETUVz?=
 =?utf-8?B?dGthTkF3ZHJNajR5OTJBNHIyWWhzaFFUMjZtUGRqUkMvL0ZNUHFWei9aT1ZI?=
 =?utf-8?B?eUtaa3duMU9MNVFPYkNsNmVBdWtqeEZQZnJPU0RvdDFheDNQelgzSUsvWDJN?=
 =?utf-8?B?N284YWdHVW1pZWRYZ1c2OFpIWEF4SXVxU0JTWXQwTWllb2tvMmlrc3QzRVFK?=
 =?utf-8?B?SlFSM1FSakx3bDFTUWphWHJkbDFDb0JRUHliczdWYzR0KzFjaFUyYzVRb1Rw?=
 =?utf-8?B?dWtwMmx0UHFuMGtSb2FNRm05N0xqT3lmMjF3Sk1Ua2RRMzNPREt3L2V1OTdJ?=
 =?utf-8?B?bDlOVXVLcUpHamtNdWNtZHUxdGIvTDdvWEp1QUFiNFNkaHJnU2k5R3RyaDBr?=
 =?utf-8?B?Mko2ZmlSTTRwMG0rbW5ZNXhTdjJrT2cxWkRnTVFLc1B3eGZoMm9YOVZFOHNK?=
 =?utf-8?B?NERSMHVBZ2VndGJEaGVpQ29SNlJkL1EvSjdLM3BoMENnSmxpK3BRQ2ZkbDR2?=
 =?utf-8?B?dS9KUnJsUVFMeXNBSEhBNWtWLzJhcHA2Qjg2WHRKMzNsa0NvT2Y2OC9CTmdZ?=
 =?utf-8?B?cWZlSll6amJJTHpDNXc1QW1DcEVZcnFXWWszWWdudW5rTWNOTU9PNFU3K2hp?=
 =?utf-8?B?anlkZkFqYkVtOUpCTGxIR1pDTm9iRGxPcGdZdkVhcHpCdXlyaHZHdmUwcWNj?=
 =?utf-8?B?TlVOMnFMbndDbjUxQktiRng0NFJ4eG5RMlJOa3VVaUswZWhlRHBKckNXZkor?=
 =?utf-8?B?bTBpZXhhb0JzcXowbW85TU5DTm12aFovQk5zellXSXZ5NVl5THlqQ0FBUFFl?=
 =?utf-8?B?NHVuYVBYRnp6em41WmRRRFhHZEFlSmJ6SzIwZ0xaN1NGN3EvTGI5b2R0YXVn?=
 =?utf-8?B?RVBvekJsV3ZkVmpmSm9MZUdKbi9hbVMrUlBRajNwY0dGbzdLcml1YkRuQzZl?=
 =?utf-8?B?QS9KYk9ZbmhuUC9jbmRDOFliNk5IbEFrWU9XaFFtL1hnNWV6U2RKZlkyYzdS?=
 =?utf-8?B?MmowMkkyRGYwWFhSR3F4dWtieFA2SEF6QmNFSjVtSGxvOStEZlNpdCtpSzhr?=
 =?utf-8?B?RFdjNS9UME9McURGQ3F0UlJiMjJPY3k5ZW4xNzJZT0w1L2xQb2NjVkJWWjNK?=
 =?utf-8?B?S25GSTB1L1lMSmVhTTdDWllVdTJWRlJHWGZtb1hBeHdOcmtCNDJtREwzdHdi?=
 =?utf-8?B?WHM2VGsyU3NZZ1c2QlJiMUVNMFZrODNyK2p1MG1SWlh3RFNiUWRmdVJYVXdl?=
 =?utf-8?B?V0lFS3l3RTBhcFlEbVlYb05uZytzVzdNQnVMaENTMkpkSmc4L3lzMEc2MXpI?=
 =?utf-8?B?WUhzaHZGUzlHWEdZNjdHd2xENzY4WEpWallndm5haWQyOHVRTlRtb0VTOHRC?=
 =?utf-8?B?a1NVbEZTME5PV2dTQVhDMnhTVUJ2LzFpaCthbTRFWkg5WjBFYTFUSGlXUGs5?=
 =?utf-8?B?NzlRMERCNWpRVkZySEtwaXpUdzNZRE5sK1p0dzhBbU5OS203bHkxMmt0WkNY?=
 =?utf-8?Q?WE5v0BLsDhRP/IGvz1iysmZhwjPFOKQDARmTpKwE3KAp?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52f6833f-eed9-43a2-7d0f-08db73320258
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB2941.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2023 15:04:42.9835 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uRVAHDrwis3l1fTQtcwNK0dU6bqmt3qQsuS2uJKZhWFm7o/CS5F/VeBbbhGXtXQ5dQJ/p0Xp8UDkzzNsPt1/dw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5416
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
Cc: amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 6/22/23 05:00, Srinivasan Shanmugam wrote:
> Conform to Linux kernel coding style.
> 
> Reported by checkpatch:
> 
> WARNING: please, no space before tabs
> 
> Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
> Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>   .../amd/display/amdgpu_dm/amdgpu_dm_hdcp.c    | 40 +++++++++----------
>   1 file changed, 20 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
> index 5536d17306d0..3f421107c3b3 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
> @@ -591,19 +591,19 @@ static void update_config(void *handle, struct cp_psp_stream_config *config)

How about promote this documentation to a kernel-doc?

>    * cannot throw errors early as it will stop the kernel from writing to sysfs
>    *
>    * Example 1:
> - * 	Good SRM size = 5096
> - * 	first call to write 4096 -> PSP fails
> - * 	Second call to write 1000 -> PSP Pass -> SRM is set
> + *	Good SRM size = 5096
> + *	first call to write 4096 -> PSP fails
> + *	Second call to write 1000 -> PSP Pass -> SRM is set
>    *
>    * Example 2:
> - * 	Bad SRM size = 4096
> - * 	first call to write 4096 -> PSP fails (This is the same as above, but we don't know if this
> - * 	is the last call)
> + *	Bad SRM size = 4096
> + *	first call to write 4096 -> PSP fails (This is the same as above, but we don't know if this
> + *	is the last call)
>    *
>    * Solution?:
> - * 	1: Parse the SRM? -> It is signed so we don't know the EOF
> - * 	2: We can have another sysfs that passes the size before calling set. -> simpler solution
> - * 	below
> + *	1: Parse the SRM? -> It is signed so we don't know the EOF
> + *	2: We can have another sysfs that passes the size before calling set. -> simpler solution
> + *	below
>    *
>    * Easy Solution:
>    * Always call get after Set to verify if set was successful.
> @@ -612,14 +612,14 @@ static void update_config(void *handle, struct cp_psp_stream_config *config)
>    * +----------------------+
>    * PSP will only update its srm if its older than the one we are trying to load.
>    * Always do set first than get.
> - * 	-if we try to "1. SET" a older version PSP will reject it and we can "2. GET" the newer
> - * 	version and save it
> + *	-if we try to "1. SET" a older version PSP will reject it and we can "2. GET" the newer
> + *	version and save it
>    *
> - * 	-if we try to "1. SET" a newer version PSP will accept it and we can "2. GET" the
> - * 	same(newer) version back and save it
> + *	-if we try to "1. SET" a newer version PSP will accept it and we can "2. GET" the
> + *	same(newer) version back and save it
>    *
> - * 	-if we try to "1. SET" a newer version and PSP rejects it. That means the format is
> - * 	incorrect/corrupted and we should correct our SRM by getting it from PSP
> + *	-if we try to "1. SET" a newer version and PSP rejects it. That means the format is
> + *	incorrect/corrupted and we should correct our SRM by getting it from PSP
>    */
>   static ssize_t srm_data_write(struct file *filp, struct kobject *kobj, struct bin_attribute *bin_attr, char *buffer,
>   			      loff_t pos, size_t count)
> @@ -684,9 +684,9 @@ static ssize_t srm_data_read(struct file *filp, struct kobject *kobj, struct bin
>   /* From the hdcp spec (5.Renewability) SRM needs to be stored in a non-volatile memory.
>    *
>    * For example,
> - * 	if Application "A" sets the SRM (ver 2) and we reboot/suspend and later when Application "B"
> - * 	needs to use HDCP, the version in PSP should be SRM(ver 2). So SRM should be persistent
> - * 	across boot/reboots/suspend/resume/shutdown
> + *	if Application "A" sets the SRM (ver 2) and we reboot/suspend and later when Application "B"
> + *	needs to use HDCP, the version in PSP should be SRM(ver 2). So SRM should be persistent
> + *	across boot/reboots/suspend/resume/shutdown
>    *
>    * Currently when the system goes down (suspend/shutdown) the SRM is cleared from PSP. For HDCP we need
>    * to make the SRM persistent.
> @@ -699,8 +699,8 @@ static ssize_t srm_data_read(struct file *filp, struct kobject *kobj, struct bin
>    *
>    * Usermode can read/write to/from PSP using the sysfs interface
>    * For example:
> - * 	to save SRM from PSP to storage : cat /sys/class/drm/card0/device/hdcp_srm > srmfile
> - * 	to load from storage to PSP: cat srmfile > /sys/class/drm/card0/device/hdcp_srm
> + *	to save SRM from PSP to storage : cat /sys/class/drm/card0/device/hdcp_srm > srmfile
> + *	to load from storage to PSP: cat srmfile > /sys/class/drm/card0/device/hdcp_srm
>    */
>   static const struct bin_attribute data_attr = {
>   	.attr = {.name = "hdcp_srm", .mode = 0664},

