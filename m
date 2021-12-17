Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB0A3C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Dec 2021 15:02:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 46B441129B0;
	Fri, 17 Dec 2021 15:02:10 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2040.outbound.protection.outlook.com [40.107.243.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 63BE01129AE
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Dec 2021 15:02:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E+WPb4cdPGzfbQfUZVsxUHrEtzJHFQA1Tfja6DSngbjQwZKs0Zh3NAAivoM729+H3aQOc30L2pTbog2kqRYn6pPRd+1GSZiC40o+CZ+HzaNuvk5zQqRH0FPf9vtpoyxjhyPZKRx1rte0+Xldr1GRJsSlGdPx/mA6clcFyM1LLkwfHbED0I6jIaF9COFiMlcBqlpRnETkvdRvRtJt5dji36kO3eqd//V/FAzQZ8uYr5O5U4V2HMW3xExTxNrkeR0tSJI4kAB9OZ1jP2czFbvzrYZr5qjBfcFEQwVQpDAzz8Z7pa58zFNDkDxj6MkIt5tl4qOvGY0IT1liWnl64JBkIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rghg8LFHWqIhzIpbEoouxfCA1DPXTrmS+a2w/s/wUgs=;
 b=AwkybF2Oe7oHs3r8v1Kin8UmPZ+6Dnqkr6zlsOex+t7gWFtjLB6OdNpafPP3v4JWqbRVzqrQhUmGThs/vXnNNDlIlv+NI8Mb4cZoeZJQtjITs2/WoSOXJYvzqp4sWb7tDTdIYhvuiG9mFWS5bHaDFeY0wTRBaYwd/rpO/WfcN81g+w/ySokZXTjqmwCDhsC12ndiXnk//829MIF5UMqPxBcEfkpTwPn0tM0htDdXUovoJqvAzCuSyXrI+23k581pj5ffaSQn0k/Ls23rvzfvVUIwSUhJvBsjJZT7sR5l52OOXvzB097mM8KLks2XzGk6zz/YFJu5PofQy0KLD3PnZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rghg8LFHWqIhzIpbEoouxfCA1DPXTrmS+a2w/s/wUgs=;
 b=wOIliVkGa3f+t+5CetmlrSnES3fX6tg9ocXdnmrPJqbsOrwjv6xL0CnqxJeDzH8rFRR31Jh7CsjRqqaJ1SWR+mOs38SJyXYUNJe6IX6a0GRMpar2ho34yLiibFK2sGKvDQeVsJlk7zdeidaF9ylOIM0q7RWQbwc/oq+V0TTaqtE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1947.namprd12.prod.outlook.com (2603:10b6:3:111::23)
 by DM5PR12MB1932.namprd12.prod.outlook.com (2603:10b6:3:10e::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.17; Fri, 17 Dec
 2021 15:02:07 +0000
Received: from DM5PR12MB1947.namprd12.prod.outlook.com
 ([fe80::5573:3d0a:9cfd:f13c]) by DM5PR12MB1947.namprd12.prod.outlook.com
 ([fe80::5573:3d0a:9cfd:f13c%7]) with mapi id 15.20.4801.017; Fri, 17 Dec 2021
 15:02:07 +0000
Subject: Re: [PATCH v3] drm/amdgpu: Call amdgpu_device_unmap_mmio() if device
 is unplugged to prevent crash in GPU initialization failure
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Leslie Shi <Yuliang.Shi@amd.com>, xinhui.pan@amd.com,
 alexander.deucher@amd.com, amd-gfx@lists.freedesktop.org
References: <20211217022601.2995743-1-Yuliang.Shi@amd.com>
 <b5b1e8f6-c7c6-b465-6d4b-75e7a709f4dd@amd.com>
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Message-ID: <3ef0795e-34aa-8748-3ab0-bd9e936cb702@amd.com>
Date: Fri, 17 Dec 2021 10:02:04 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <b5b1e8f6-c7c6-b465-6d4b-75e7a709f4dd@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: YTXPR0101CA0018.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::31) To DM5PR12MB1947.namprd12.prod.outlook.com
 (2603:10b6:3:111::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f27b3f57-5bfc-4706-c66e-08d9c16e3152
X-MS-TrafficTypeDiagnostic: DM5PR12MB1932:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB19329B62FD06D6872C7039F4EA789@DM5PR12MB1932.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GmCmbAVdmQCOXFXi2HBNgbTKPe88niJuxTNHTD3r1rg/wUQFEofeK70BhAA3xWPkVFypBLWXvS0wOZey9oZ1TeObfH997RvEaZjT5Q4KLFt2ZE4v7+g3M+kP/rw/DSNg69yRNctNlSrteCy67ltlhvs4CbLKkjKitg//aM5b7uyrErBr2/mj7L2QnHsM3Gr44p17xVRQdZJn4c/jwaTXd1GXVe/rMwXImk0q7MIPdUlE8kI9Um3XV6OvvzyIa0f8ZkjlcNnPeZ8MzM7z9WvPaCZ/erP9JGgfGaU1nmx/e2cMISlqxqjxFhmPo3P0fXbIiMMVtwZqCPx46davodv9HcH4HhWdIXXa79tAoNMJ5ik1rdAyMzySiNyrML/e7b3lxxNpjfARxr4QAYpcplYKt7QKJM3KMYXbuL+p/7IQBqPRJr7O9N2MUethI0sKIyNmZV8CeMSYgWN0GYtlmuUZYADMI26kfw6zDOiNebNXdyDd7vDEBhl1/WMvM2bCFPrAZDY1ik4omOQDfKOquyH1WjVM736jr1PzAR1OaS1YgZeef1XGQyzC60Rw/ANX4LhslCL8qmjr5wFSnvcqWd2VDg6IwfRcJ20fAl4WekXyOonta6/DA5FUt8QKZrv5ekCnCr+DS2V99DJ80zXMQCpNwRKC7pQdoPo8dSzhwNDRuJApjoOSzpXKqlOCslbYS0jnb+a8UhoZ6XBslFb4Caq1zJcDaPQ0WorTD5AsICrW0F8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1947.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(66556008)(110136005)(186003)(66476007)(2906002)(316002)(5660300002)(8676002)(4326008)(2616005)(8936002)(83380400001)(44832011)(86362001)(6512007)(53546011)(6506007)(38100700002)(6486002)(66946007)(36756003)(66574015)(4001150100001)(508600001)(31696002)(31686004)(6666004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V3RjOVdzMzF0d3dWMytneE1HUEF4VkF2ejZuYUFDSmJoV3BJUkZyVFFiZUNy?=
 =?utf-8?B?aENBVVA4dFRmOWZQWWNJRGVmT0ZqZDdDNTJpMWp2RG51ZlFQNVNpdExKNGdX?=
 =?utf-8?B?b3kyQS93T0VaS3JlSXBBNkpzWGVPYzRtbEZKUm8vWkhJQXJhd1FHSjE4bU1D?=
 =?utf-8?B?cVdzdEx1TGZJdVhXS3lLck1qc21oZlNBb1lOcCtTdWVBY2RqbFBESVRVc2Y4?=
 =?utf-8?B?NkdxMmxjOThxeTVic0dBUi9MR1JiYnAya1lIRUZiWll0Um1kZGlDWFpXQnVv?=
 =?utf-8?B?bHJXVEFYY0t4SVNzb3gzSm14TGVoRjRnU1hDQ3VNU3FBRXNNcU12aWxtQ21I?=
 =?utf-8?B?Tzk1Mk9NKzNDa0JIRlhZc2ZFVHVoODFRREwvZUR1TXhNUCtTY2JrTG16aTBZ?=
 =?utf-8?B?dlV2dmRYdHdzS21kVlJjTXR6OTRFQ0NLUTB1bHhBUUQ0YXc5TWxWSENoWnlk?=
 =?utf-8?B?L0V2aVVQL1R5NllvcGd1UGpXaVZZZy9tK24wT2lsWlJVTTA3eGhDQjFySnQv?=
 =?utf-8?B?M0M5a1JWSGZ4T2Z1UEhUUnBjREhyY0JYcSs4NDVISjhudkNLYzlYTWorK2I5?=
 =?utf-8?B?bGE3ZEVCQnZXSnZ6ZHNUSnlXd2luQS8veGp5RWFMRkJqN2NLTXFtM3lha24x?=
 =?utf-8?B?MXpvcnlMOTlSdkFOczQ4WG5CWWx3MEFJZzNXcEJKL1hScHRqMG1XcnlsQU55?=
 =?utf-8?B?QktLb1g3ajRpNldHQmxYVmtFWDVPMUdsQ2dCSVJQT3psVSt1c1pqeFUzd1Ux?=
 =?utf-8?B?cWVGaEpBUEVDQ0RSTGwrTFhUQkVGcVU0YXVsVnJCVWFtMjdudWJlbks5VVJF?=
 =?utf-8?B?WFhHc3p1NHhmVTkwTnQ3ajJ1eDZaaU5XT29ybHFtZi9hbzkwYXMvWjZ1VmZ2?=
 =?utf-8?B?TFZwU25GZm5RbEZFTWNBTmhKdzZ5djhpSTd4RHMvaGFCYW9JU3ZQMnYzYmVR?=
 =?utf-8?B?cHdIV0d0WktGYkZGSmhPaStsUkszVFBrbDUwcU9ncWRULy8wTXAvR0lCMytv?=
 =?utf-8?B?V0lLN09rTnB3Tm5pTVdEU0l0SjNlanpRSGtrUElDSmN6KzhyOWd3YzVEeHI5?=
 =?utf-8?B?cC9KWjVIQjhEZVVVL3ZWV212UGxHM1hyOWl0ZkRZZFE0SCtzSjYzSmdsOEJT?=
 =?utf-8?B?RnNtdDVPalJ3bW85YTVWY3dLMmxFMHNVVFhDbkJXbTJHK05aNDNDdEJReWRr?=
 =?utf-8?B?TCsrWkdRaGFxZVIveEY3VVdKQmF1aUdvVzNmWTVYTkh5QXlBYWpQaW8rWkJZ?=
 =?utf-8?B?VGg4bUE0VHpOa3MrU1BFWWFIbHZVblQvMkQrc1JES0JMMGp4Nng3VE9pTHR3?=
 =?utf-8?B?U1BLRnBOQVdUaW9IZ2JXWURTSXdTWGZYa3I1ZlVCMzJpWGpWZUxKNU1udEV4?=
 =?utf-8?B?Z1VNbDdhVjdrZUloN1Q0LzZyK0NxdlBnTEI1aCswMWFjRlVxb2grYWthQXJG?=
 =?utf-8?B?OXRpa3E3REFZMzRnR2hHdVpEbFBTZ3JQK2dweXlJbDd5dnVqZFFLbENjdFJz?=
 =?utf-8?B?am5vY3h5bmlXRC9Vdm5CcGxINzVxcldSN2ZYVGZtR1BTSk5WNmRtYUkyUG93?=
 =?utf-8?B?N0hwS3Vvekk5dG1LVC96QjBYT0Y1MnRSdkJEMTZZMFJIbUZSRWUyTng4WnAy?=
 =?utf-8?B?TVoxc1grUWxUOStQV1E0VG1ZeCt4aTdKMkNxdlJKMWNaK0JmZmJSV0owTFNq?=
 =?utf-8?B?U0trY3N2OVV1NmFDbThyWlJoc0VUYmtKdnhiVFFkanlPckdqTzZyY2U0aG5h?=
 =?utf-8?B?MjJWODdiUHhhOVg5dFNTR2RpU3MrVlVXRjMxWnNtSXRjc216dTluMzRpWGZV?=
 =?utf-8?B?V3piZnltYXVEU1ZJUlp3aitrbGhVVDB4aHZnYVkvclhhRVpEbXZhbTY0Q295?=
 =?utf-8?B?TnZZM2lKMEdoSjNXU0xkOGJUQitDTzZXV3RrVnZKSmdSOUNiV0hSSTF0QnBR?=
 =?utf-8?B?NEVUblVvVi9DdVljNjRWVmQzM3VHMkw2Uk5UMVVZWGd1MEs2YmFoL3haZjBF?=
 =?utf-8?B?OVJmNEVMN2s5SEVjS20wZE9vWDhpQmc3NGJpWUFSa0hoMDFlWnIzSHNJTG5v?=
 =?utf-8?B?azllUEZxQTllVmpZWTZYVDFWK3JKRTVaTWM2ZHJ6cDFYZ1NtVzhYaVdjUjZ6?=
 =?utf-8?B?RFRnSnZnN21ZNDVURElUZ25zdzNqTGZhUkZ1R1REb3RrVzNiUmdvakswb0J0?=
 =?utf-8?B?eVFZT1ZsTGRFZkkzOUkwUlB2R0Fvc3F2bkQwbm5uZTlFYTgrQzFvaHNzTVB5?=
 =?utf-8?Q?ZorKmILNE5uv1omt+dmeSgAEqWvwBa4T8Qy8LovO5M=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f27b3f57-5bfc-4706-c66e-08d9c16e3152
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1947.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2021 15:02:07.1457 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6UkYBFr6jtR+TbvG8ZmZ1F5Lbw0PBFehDHWNWNCSOAi4GNoPFAwdZJS7ekENVxVAUg4nmqBVz2g5mlm3EKaEHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1932
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
Cc: guchun.chen@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Reviewed-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>

Andrey

On 2021-12-17 3:49 a.m., Christian König wrote:
> Am 17.12.21 um 03:26 schrieb Leslie Shi:
>> [Why]
>> In amdgpu_driver_load_kms, when amdgpu_device_init returns error 
>> during driver modprobe, it
>> will start the error handle path immediately and call into 
>> amdgpu_device_unmap_mmio as well
>> to release mapped VRAM. However, in the following release callback, 
>> driver stills visits the
>> unmapped memory like vcn.inst[i].fw_shared_cpu_addr in 
>> vcn_v3_0_sw_fini. So a kernel crash occurs.
>>
>> [How]
>> call amdgpu_device_unmap_mmio() if device is unplugged to prevent 
>> invalid memory address in
>> vcn_v3_0_sw_fini() when GPU initialization failure.
>>
>> Signed-off-by: Leslie Shi <Yuliang.Shi@amd.com>
>
> Looks sane to me, but Andrey should probably nood as well.
>
> Acked-by: Christian König <christian.koenig@amd.com>
>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 4 +++-
>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> index f31caec669e7..f6a47b927cfd 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> @@ -3899,7 +3899,9 @@ void amdgpu_device_fini_hw(struct amdgpu_device 
>> *adev)
>>         amdgpu_gart_dummy_page_fini(adev);
>>   -    amdgpu_device_unmap_mmio(adev);
>> +    if (drm_dev_is_unplugged(adev_to_drm(adev)))
>> +        amdgpu_device_unmap_mmio(adev);
>> +
>>   }
>>     void amdgpu_device_fini_sw(struct amdgpu_device *adev)
>
