Return-Path: <SRS0=XefO=O2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A9BAC433EF
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Oct 2021 12:00:35 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E57526113E
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Oct 2021 12:00:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E57526113E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 297406EDB4;
	Wed,  6 Oct 2021 12:00:34 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2061.outbound.protection.outlook.com [40.107.244.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CD0B96ED22
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 Oct 2021 12:00:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TvabIf7QejaAatPJeQjAZdEa07IS3IGuIIeUnW5b7zIRDhl77Q8TMaPR/HK8G+Ydq4gN7ncUQAeAG+vE86gKaPM/kDU56XEf4cskGYuOBlUDnrTgvb7atR1aNX5t2PCybf80XVBLxocCevhUuN2jTGfz7ZQ3NV8Mm76dNB1nJqM6WUWQm8VNXL4TnfzclZjfsRdxPrnr2VLRhJjv4gGKvX4WR7UyLiUuXXxBT4b0VH0QmwZy6dd16E+r039gBayg6frQZm2EzJPhA55aabduNvqH1hQJRxJK9vsaFdMOmNuDVuZ9ixFBLKj4vwU0a69xU8st4FagAw4t+g2YkWQbLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hgHn19puNlF2OzhVZxWetCpYSJWLPbGHJvAgmae6xQ8=;
 b=TRWzhgSGuYCD/oEFR1O0rIraw4/EU3u8XtpG7IstclgGRgeaiPsgG/X3THAEJEYvDgNFofNW8hsKc9V3iBPsbnb0upL1lkNDCH/W7v7cNePbqB7CPmbx16CCVUCcrOUvTcBKdKbktG9s9MJI7E7L7zvfVsrSTWLhda7XNpntWQaT3hXb5l7Mbw5GHnwIZa61/uXcU2QUgrKtN7Cnwy8Z5igRQ4mjCO4Dv1QdfRoX7VlPxcLFKbxjIOcv0Zh1hI10HMagBMBH/RbiQEIphlkhb0S1gBfutgQzpE1IbUmlhGKK8ymw0s0ovKV2JbZ+e7In2zyrNi3f09YN/fQyLhM/Rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hgHn19puNlF2OzhVZxWetCpYSJWLPbGHJvAgmae6xQ8=;
 b=r4UZo7bsmPfIU5Q/yy96UNETUi8vMODlrCikuvKp+GXuVW/aC2HX6uThuLxWeu4xbcyiHnb8FFZTgrRIIq5xkWBIQ8+iWcSgPeFGPPUiUYd0xFEJaib0LQNBD2sLnGrRe+2fQdgapub8IDx0+sEnJvRX0I41NXENuZc2yGX7YQQ=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MWHPR1201MB0192.namprd12.prod.outlook.com
 (2603:10b6:301:5a::14) by MW2PR12MB2491.namprd12.prod.outlook.com
 (2603:10b6:907:f::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.18; Wed, 6 Oct
 2021 12:00:30 +0000
Received: from MWHPR1201MB0192.namprd12.prod.outlook.com
 ([fe80::55c7:6fc9:b2b1:1e6a]) by MWHPR1201MB0192.namprd12.prod.outlook.com
 ([fe80::55c7:6fc9:b2b1:1e6a%10]) with mapi id 15.20.4587.018; Wed, 6 Oct 2021
 12:00:30 +0000
Subject: Re: [PATCH 1/1] drm/amdgpu: return early if debugfs is not initialized
To: "Lazar, Lijo" <lijo.lazar@amd.com>, Nirmoy Das <nirmoy.das@amd.com>,
 amd-gfx@lists.freedesktop.org
Cc: shashank.sharma@amd.com
References: <20211006095116.6221-1-nirmoy.das@amd.com>
 <b4fd745e-dbfd-70c2-5d80-6b00dc268601@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <cf004c20-8267-f065-a559-4e125069e768@amd.com>
Date: Wed, 6 Oct 2021 14:00:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <b4fd745e-dbfd-70c2-5d80-6b00dc268601@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: AM0PR08CA0014.eurprd08.prod.outlook.com
 (2603:10a6:208:d2::27) To MWHPR1201MB0192.namprd12.prod.outlook.com
 (2603:10b6:301:5a::14)
MIME-Version: 1.0
Received: from [192.168.178.21] (91.14.161.181) by
 AM0PR08CA0014.eurprd08.prod.outlook.com (2603:10a6:208:d2::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4566.14 via Frontend Transport; Wed, 6 Oct 2021 12:00:28 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 25a6bc46-3a8e-49ed-ae86-08d988c0e4be
X-MS-TrafficTypeDiagnostic: MW2PR12MB2491:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB24913BEA7E9A36FBB96356E283B09@MW2PR12MB2491.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:510;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nRLBAz7phfJVGmMxqQ8oGjsL6nthdp4+VIfiWriz458VzjW+OKBueGD32QlmMMi5vy1Ly3F0j9YxjbUtuejKRLj5a4/OfXdt+LdVf7FebgucQsIYu+CiC/AMNxdKf858woMXWUopQnvieebLUJbIJG06+eBuRaCPBfxBnmGfjjU9iQeRpNYBDiivX7Fn+O4fvGYhEGEpnVughJPTJTvNuzYCb44GAr4LrYwo3WbtXzkFnQ4kLhbMMTegdC9DXgMb7DA5FZb07P0D8xP3XnvHo70zA9l9CfUNcUvoBqiK/srbmQkxE4snRyUAW841Wif0PssAvDURcAsDW3V4vi6/ZVGz8e6AjsUYv2Tr9Yzkrhu6D0twH+yZNRy53hNUM/5LRMWDDsQiY5RyYRMHknv8zrJ02X4ZmwOMBBTUz6tOSKDo7OlfVxz8PRh4X9hf6gItQYAUNv9nL7eRFS+kTffn9iR+ywgfWl81Otm6GMziBMFB8Im6mbL9hWJEYrm8f0gkDxkkQgPJ6ie4urI0GGutdsHw0xlBp6ToC2DJ46lgSs50v+5VcLmY7/YaP5pQERtXcJqsUKrBdIIwvqlWoQDKtDpI4yTSxL2M5A31G0swUICimJIdXKML/karuQmT6NrzgpjP1kY+CkQgSVoEgZfgPed1ApX3kPu9E0y9XEfJXoBWGOYVMqNOmLkAw1TWuCFnannJJM3MnidJQp3mHcI0rvwC4ksZpYqg7gqOABCW98l00tgUcf6Mp139Z/uxSMLLiT1O4DcaNUZCDpPwuweyT/C1s0B/d1MFIPWmkUXtFJemwRM70WLYvGTI5yuzJV+cwdWtUBHx/T/AjUK51u+Vog==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR1201MB0192.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(31686004)(36756003)(53546011)(16576012)(186003)(2616005)(4326008)(38100700002)(956004)(110136005)(316002)(26005)(6666004)(508600001)(6486002)(86362001)(31696002)(2906002)(966005)(8936002)(66556008)(5660300002)(8676002)(66476007)(66946007)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K2txcXg0ZTdPaU5TSG5IaFNxWXNBSFNpWjMxZmtCYkE1MkRiWEhkZWNnUnQr?=
 =?utf-8?B?VmtuNzVBdnJTZnp2VVhHd2s5czFOMEJ6ZmdGcUwvUEtXVzRrdjBuSURQZkZ2?=
 =?utf-8?B?Z0dvT1RsaEVOdFNiSmxUQTd2a3ZYaGJ6VzBRWHJSenVxQWJJZjVGc3NDRGFY?=
 =?utf-8?B?UXAzeTlJQ1JoeTVNWmhGbCttSEkwV3hTUlZsZXBLU1d0bUlKU2VDY2phTjFF?=
 =?utf-8?B?S29SRllFSzF2RDI5TFd2a2Mwak9VTXh6S1k5SWRYM0U3UTMrMjJWenlxUCt6?=
 =?utf-8?B?NmhCWGdjdlJnaFpremt4aERQVVVrVXJydmZ3TVlwQVhJQml5emJmdjhhUlJZ?=
 =?utf-8?B?NzZZNHM1a3Vid2ZmZjdPTnQ1ZEphSzdKNVprVUhLZElhcHd3clI2WFM0NUFS?=
 =?utf-8?B?MmM3Tk5XcjJkaGtnZ05XaWNsVGhuTXh3cW84REdKcjR2aU9BTTlBb2lSekhE?=
 =?utf-8?B?THVReEhSV3RBa0RIVDQ3UlYrKy9UU1JQL2kxWVpab0VFQk1oUUJyRVpUeC84?=
 =?utf-8?B?Y2UzTTdkSTZ4SElMV3FUQldwaVJvM2gvVkpjQTc1dXpPd0tWYkp2MWNCQU5r?=
 =?utf-8?B?SWp5SHhDK3lONFhKdXJ0N3dNa3FBRGJHTitDWWxxNlNqOEdxT25OT0g3UGJh?=
 =?utf-8?B?eVEzMjR1ZU5NNkdwaFdoK1Jtd0JNcUZldVJOb3RpcERlQkRDMzlQOFBNQ1Uz?=
 =?utf-8?B?TEt6SVc4aWtDZDd3RmQzNWtLTDBXdFQ4S0JCS0FiV2UrYTBrV1NlSXoyMlJv?=
 =?utf-8?B?cERsZkNUYk1GRy9peGEyNjRpM1FpbElDT25VZCs1TkdENWpVaW0wM3dNdnRW?=
 =?utf-8?B?R2R3WklqNDNnVXVmK2NEQnNYZzZkczhxckpCTGhwNEhCMndqRHJPeEt0b2Rz?=
 =?utf-8?B?RDdrbW5UbUJQbGNsT3FvR3NNTHRmKy9BNHZ3K0xkMy90aUhtNnBUVjc1TkZW?=
 =?utf-8?B?aFpTWHlTclVad1Fvd2hYNittYS9IZG5kenZRcUpEWlBvWDhDREx1NnFzWWh3?=
 =?utf-8?B?OVorVTlUVTF6cC9abFJFL096Y3l3d1N0MFY5L3NCanlpd0x1SDA0L2hSbjI4?=
 =?utf-8?B?VkpCYjBWUDhaamw2ZXpaL05TZW9MODBMWGZDc0kzdnZCb3JONVdqTXNnWEhu?=
 =?utf-8?B?Tmk4cnM5c1BCbHVQK0w4OHpRUjVydDUwWk9FQjdwdXNNVmt0TDBZYUlmcXgy?=
 =?utf-8?B?UEhRVHpET1poRmlsV0k5azEyTG9JSmNXMFByZ1BabWthVmdxZmxPS3FXZWxK?=
 =?utf-8?B?SmpzaEZGY2VYdEVSZDFwN0t0T2xQYkFieVg1VWtrSjd4MFhDTjA5YXNENVZM?=
 =?utf-8?B?M1VLSjBqdE4xM1dYKzdBeXdWWVphUjd6ajVMdzl2bk5JclVheHFOM1JSbW1z?=
 =?utf-8?B?RXBkUzc5cCttMldaUlIwbmhHWTlPU0ZETVJqNVg3dVcya0kxOGNkQm1Dc2dM?=
 =?utf-8?B?ZUZrektheEVDOEhacjlHeDZ1L1gramxPS01yRStocXRXVytXeVNML1ZGYjEx?=
 =?utf-8?B?RjFPRHdYanB3b1NENGFEN0dlMVIvdkV0Tm1JMEx3ZkcwSW9Mdk1Nb0Y5M1Rw?=
 =?utf-8?B?TmtXVjZicFJQTGRkQzhucGxPZWV0dU8zOU0vUjBUVVFTK2s1VDVucXdKUTBo?=
 =?utf-8?B?U0F6WGxGNjY2MG94bXdvMXpJUzBvc01zblcyY0oxRk1wbkxwWEJWcGIwR1dG?=
 =?utf-8?B?MDk0WXJvNm50RnVaN1JrWWFnSW9BczdCbkZWZ3Jsd1Mzb3VGaHpNeldCc3JN?=
 =?utf-8?Q?I5xPs7cfckjyhwBTc3c5y5KUCdANfQrOqccVNns?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25a6bc46-3a8e-49ed-ae86-08d988c0e4be
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1201MB0192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2021 12:00:30.5084 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YNTjV/UPRwNJARXl+siejrIaZFeSd0S18yRb8+kH08DnHER3GDKGRY1OSAukqiRp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2491
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

Am 06.10.21 um 13:55 schrieb Lazar, Lijo:
>
>
> On 10/6/2021 3:21 PM, Nirmoy Das wrote:
>> Check first if debugfs is initialized before creating
>> amdgpu debugfs files.
>>
>> References: https://gitlab.freedesktop.org/drm/amd/-/issues/1686
>> Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>
> Sorry about another miss. There is one other option added in the patch.
>
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=a24c6f7bc923d5e2f3139855eb09b0d480d6b410 
>
>
> "
> config DEBUG_FS_DISALLOW_MOUNT
>     bool "Do not register debugfs as filesystem"
>     help
>       The API is open but filesystem is not loaded. Clients can still 
> do their work and read with debug tools that do not need debugfs 
> filesystem.
> "

I'm really wondering why it's useful to have debugfs enabled, but not 
mounted.

>
> This doesn't work under this mode. Guess, we are not worried about this.
>
> Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Anyway Reviewed-by: Christian König <christian.koenig@amd.com>

>
> Thanks,
> Lijo
>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>> index 6611b3c7c149..5497e2d31d1a 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>> @@ -1617,6 +1617,9 @@ int amdgpu_debugfs_init(struct amdgpu_device 
>> *adev)
>>       struct dentry *ent;
>>       int r, i;
>>   +    if (!debugfs_initialized())
>> +        return 0;
>> +
>>       ent = debugfs_create_file("amdgpu_preempt_ib", 0600, root, adev,
>>                     &fops_ib_preempt);
>>       if (IS_ERR(ent)) {
>>

