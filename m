Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0195CC433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Jul 2022 17:38:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 67D81ADF93;
	Mon, 25 Jul 2022 17:38:02 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2047.outbound.protection.outlook.com [40.107.93.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4722EADF93
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Jul 2022 17:38:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PqIWXycg5SrHxlFV8SrEYh0Dg8dDxAyfucOFmNhOnEpANa0Q+XN9LgfcsP9aB/o/mlIhpfP1/kSpw9AJJZpBkIN3lWldQWK2rAJ1/VHv+oqfTcFprbBQuSzDRzEFfq9SoRVYyEWGZGiO14mSoMC+3oNSFPZRMheiFN+RvrwKCkwhgMFeOSXVd1QXaWdfTRvD6v/F8lXuH8YF1t9Ox3RNQDfKR52XToWRgIVKUMauupKfGJmoDBERk+KmfNZDTP+4Quf2ty/5AmixydKShYrEKxaZa3w2SMKZvcr/XkoFo30jDdQrGeFytFpRu8FDrwB2KgiZnCeamlA6gIgbDVc6tQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6NV3Fv4oQRr0tSitbdjGhaigxf9iuTTyH8qRUVN+Vc4=;
 b=LAdlYXBoUNwY5xzdlN3aIIQ44Ex6Vnaw2EAGNHzitk2NB29FGfaC5Zbh12G32qj6WJl0RWCgjREo/dMgSgFwMz4fXjTMHf4r9kVolxXt7UE7gfhxEA+me3piYt+KidB9cO0uR2yV9Yxj9Qn499TLcvAmMZa84UD6lK8s1VAPNOz6uZy5k0HwTFzAKru4WuRGZCCHjIfDHkh99xx7+f+aUzMUjrH2VCfQnlHHkVS48JjqXOAcupLWJevHqAOvx61A3M8faLyelcsGKXVpbbPxn3gT5fk7+YyXf0h5wmdLVqJnRFakhLRG7RgmjS7FJLC16Qnp8vqNQ3Fs+Q/mcO9I2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6NV3Fv4oQRr0tSitbdjGhaigxf9iuTTyH8qRUVN+Vc4=;
 b=o83O/1cAdjYzWajrClkFArIg3rl1YQv5W/Ti/mOeSvPMRF6JWIXByASrNcr+kAAE2KQKvNzVsaJgEwEuUleoNuat50O8IxdQcFk5O2vNIIuO4LXQDa7ANzN7UE6tmsvLXyMCXUVKodD1zyhuG4rS8mkeOGpAWMdQpMq7TWLMuv4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by MWHPR1201MB0031.namprd12.prod.outlook.com (2603:10b6:301:57::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.19; Mon, 25 Jul
 2022 17:37:57 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::905:1701:3b51:7e39]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::905:1701:3b51:7e39%2]) with mapi id 15.20.5458.024; Mon, 25 Jul 2022
 17:37:57 +0000
Message-ID: <039ddc04-386f-4032-f9a8-bd9950507765@amd.com>
Date: Mon, 25 Jul 2022 19:37:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 2/5] drm/amdgpu: add debugfs amdgpu_reset_level
Content-Language: en-US
To: "Zhao, Victor" <Victor.Zhao@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Grodzovsky, Andrey" <Andrey.Grodzovsky@amd.com>
References: <20220722073403.5171-1-Victor.Zhao@amd.com>
 <20220722073403.5171-2-Victor.Zhao@amd.com>
 <30f6ef1d-a1b3-3228-37f5-3cfede6431b5@amd.com>
 <DM6PR12MB43400E00CDC78399E92D6FB6FA959@DM6PR12MB4340.namprd12.prod.outlook.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <DM6PR12MB43400E00CDC78399E92D6FB6FA959@DM6PR12MB4340.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS9PR06CA0696.eurprd06.prod.outlook.com
 (2603:10a6:20b:49f::13) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 10c91806-271b-4fca-8fc9-08da6e646969
X-MS-TrafficTypeDiagnostic: MWHPR1201MB0031:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iA5eIookUTNe7uDooji91DHr2WXbgvRW6RDwBp3GG7BJOVK+fDRdJoy0oOtrz2S0VvcA7j6QB+uSX+RFvrh7ZwINsriJmmLcyeruwupDjEWat86amZ9rPeJ+sUyesr1ak6EtIR4LfeV25ToZ6WxtB9/fIcbDVFz6yEaccM6xo5KSpebhQBdD3IV5ZH1hr+sX4zKRYoHVbH/P+DQbhrwaforJHsAxs+Qr6YanziusmCe/o58rleJTtWUqPGd+9jqu4cSAKwIXCe2DbY6VOv3hFiFWtltNXPt0Xcoas4mZoYMHqfceePzsS9YWQe8ss2SXPiReVTaHvVZAazCSTUqJHlqItxZSKDIxygJZ+QK9cW1HxLDs6YCd9+2qIKuAMUa62oQdefsWCZxq/DWJ3nVmZFbPrO1RHGp1OxnusHsWxyHMJ0+YmwBdVIsKkvphgtKoTXzT9/cjZjIXfG3KpKWmwz2pwGpcRH2bQ/RdNKeusnFOMmD5vdwzKlMzrW9PtuJP7W/pHZFJt3ktyzqx+j0V3mR512rY4GH4iJLcx9u7ttki85bBXypuv7ppGe/fWAMGYXoz3BkEdLuq51HVZxTfSuhmKtXnDnH4/Iuvy8g32rZjIeu3HzeMHSKfjUwbBbEw4Kl4nfaKnIGMFUKU5qAWYiywBTSFCL0HPwNlmENK+N7b9nYVBhACFz/CyXQMtNJscsakdGaNnK6ehIfsogjf6aI6TcWZTD70U1gOcJPs/GbWjdf4a3kyrv2meb98YXpeRicHYmgavRKd2LAW9MURpV6HhITTwmT6uZxgKt9nOnPfPMyEUBSXZm2SrZAqDWy4W8+Bc0tEkl1e/By833EfLw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(376002)(396003)(136003)(366004)(346002)(39860400002)(83380400001)(186003)(31696002)(86362001)(6666004)(6636002)(38100700002)(4326008)(8676002)(41300700001)(36756003)(8936002)(66556008)(66476007)(66946007)(316002)(31686004)(2616005)(478600001)(6512007)(6486002)(110136005)(5660300002)(6506007)(2906002)(53546011)(54906003)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Sm5pUVRjMklvMFl5ZkJMUWVETWJFS05UeGNGZ294dmFqM3N0eERiamNwVHc3?=
 =?utf-8?B?OGphbUNZQXArZXJ4M0NQL1lwcUlweUlvNXVycTVOUFBnMnZUcHN1bENqZlZ1?=
 =?utf-8?B?cXRTL2pDMzM4MDg4dmg0RWJhdFdGSHIwRVk5cTlkZFZxeG5oRlg1NU9Dakdi?=
 =?utf-8?B?eTlFTGZucXN0MjdrTEw2QkJOcEIrVTFHNGNJVElmemJ5RHJLTVJHUmNrTllL?=
 =?utf-8?B?YXlaOVJUQjRoeGhNQ3E0QVp0QUxRamtEZHF6MnpIaWYrNFZ2MjVhRlFwTU4x?=
 =?utf-8?B?NzJSdzZzcjBMNmhRRU9NWVp6UnlKT0RGc2VUWU1rZDNPN0FBUXJrS0R5M3BM?=
 =?utf-8?B?OVNPWDJBU0pZZ251aFBtRHJGcmNJMk9vVjNyVUVKVGNqNVFNYUxmRWFiMlJ6?=
 =?utf-8?B?blhGTjdEendCNzQ0bm9JSitLQ2FvRFhjcElUUTRJbHBwdDUrcFk3Y2tRTGE2?=
 =?utf-8?B?OEdJcncyR2xpL1YzQ240ZCtJU0VseW42amxsMWJ6VDZ6MURGTHJwZklFb2Z4?=
 =?utf-8?B?MDF1a3RDM09PNlRoWHR2MWd6cDFFUWh4ZVFiZDdKdG00U090b2JRdnlKemtp?=
 =?utf-8?B?cVBRZTNGSjlQU0ZuQ21KYmNyclFUUHp4bmZUNFVYQ2dZY3ZycXpNeXF4b0pt?=
 =?utf-8?B?TnFMOEVTMnlOYzBCMjVFZFFnUUxRZm1lRGN1dkNyaS9NZi9IV3hKZHlqS1kz?=
 =?utf-8?B?V3hkSndCc3BTNnVrcXZRUU9iVHc3dkVFR1R4UGZUNnk4UjFvdm90OU9vaE1Y?=
 =?utf-8?B?aW94Y0ZXbWtma0YrRDJMTmtYZXJvRFF4bHNhby9CekZBL3N2bTE3VzBoWS9n?=
 =?utf-8?B?V20wQi9QR3puNjZqTmEzWEt5SEdkbjF5c2hsY0VxUmE3M1o2bHROTHR4NFBk?=
 =?utf-8?B?bEdweld5Wnh3MDFOdTdpZGVSVWNudk1rL3A5bXJFTHA4ZTU0dzJyOFhOdEU2?=
 =?utf-8?B?ZGx3N0szT2FmaU8zV01VOUpXVmJBTGFnMS9ralJySWdHTTVtWmRmb0lzWTl6?=
 =?utf-8?B?cW9ZUzllQXBlb3RwdjRLSVNuQloyS2t1eE9UY1lTQmVZb3FBaGJFVU9mZWQr?=
 =?utf-8?B?RmpCZ2J4S2VZOHNDQ2l5VVJBUDZTUUlIQUlKZnhoU1EyRTZvOTR2NzltVkJK?=
 =?utf-8?B?MkJPcnhyeTJpK1JDN0dyWHFpbGJ2ODJnUm4xU1FZekZkbDE1cFRIOElaV0JT?=
 =?utf-8?B?YjUvanRtMVl1a3U1aVVwS0JuTXROVHZ1OTc2UFVRRlVoWWdNYU9Call6ZHAx?=
 =?utf-8?B?clZPalVxOGdoYVhyNWw5b3FYSitCQXkzR0tadGlaNmthQ2F0UFZWOXZKM0JY?=
 =?utf-8?B?eTdNNFlCMFZXU2M5THUxUTV4dXV6U0wxb2p6cFpjbnhFcmJiRzJzdERxRGJo?=
 =?utf-8?B?QlBhQlgyY0JNdU9aVWtHYmxPM3d0N0s1ZWNXMFcyaVJXVGpqZU1MOWlyS1R3?=
 =?utf-8?B?NWlDQ0ZmZ0FMR0d4K29VdzBiYysrc3pURFJ0S0pVT05OUnFLd0h3MzhTMVJs?=
 =?utf-8?B?bmRiWlh0bDRuUkNCYlQvMmg1NEpaR2VHUWR3VDVKVGhvc0wrWHFCT01ZaVVx?=
 =?utf-8?B?Q1h0MWtFZTVuZkp0TXhhdWpCb1U0azRuTDBwQkRMQjZObGF1cy8zMTFoTkpM?=
 =?utf-8?B?ajZxclVTcWlYeVYzN1FrVkNmQi9rV3pma2NUazhVMTlEOUNCNWxTbXVRT2tJ?=
 =?utf-8?B?UGJrODBMVU5aZTYzaStFaUgwVkV4bnhuNyt1NVFrTHlSanRYRDhaSG1PZVNE?=
 =?utf-8?B?SmpDMXhWeGo4ZitqTmxOY2hSV0xzZEJHRTRBVmJSaU94NnJmSllFUTU2UjA0?=
 =?utf-8?B?L2lFbHJ6amlNMmFvbUl3MmVQanRFYlI2QlBERURKY0JLN1NpUGRRY0kzRmNE?=
 =?utf-8?B?eTJhbGVqMkxUdVVkeWU5OHp2U1liaXNaZmVPdDFpaDdYMlV1WnpTSnJGM0Nt?=
 =?utf-8?B?akk0WjJ0Y3NsY2hWdmxXaFlndm05TlduZUU5VitNUlpTdWVoTzFlS3pIYmN5?=
 =?utf-8?B?MXJxYlBJNStuL21wUG4zdGIyYVBoVWZiTUNoekQzdHhIbVVsL3VVTlBDSWsv?=
 =?utf-8?B?c2hKQVcvbHVKVUc5Rm5RelVMM0NvZG5STFdxeW83aVlyWUlJN0VaK3MvTy8w?=
 =?utf-8?B?anQ1clF0aGk5WFUzalhtbE14RG1MNnlEZ0ZFS2ROam53V0FnU1hjSU5MeFha?=
 =?utf-8?Q?qAbfSlT3EaO+gmhp48UXvaDUUbrJCD9tLdYJ6xUodfQJ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10c91806-271b-4fca-8fc9-08da6e646969
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2022 17:37:57.5969 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VmnxhJZTLOFaPExSBOKI8AVuHf/DAUyAQKU2+26KEJNLrp+GeJIwk9To93SVaMMU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0031
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Deng,
 Emily" <Emily.Deng@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi Victor,

Am 25.07.22 um 12:45 schrieb Zhao, Victor:
> [AMD Official Use Only - General]
>
> Hi @Grodzovsky, Andrey,
>
> Please help review the series, thanks a lot.
>
> Hi @Koenig, Christian,
>
> I thought a module parameter will be exposed to a common user, this control was added to help debug and test so I put it as a debugfs. I can make it module parameter if more appropriate.

That's a really good argument. I leave the decision if we should use a 
module parameter or debugfs file to Andrey.

If you go with debugfs then using the debugfs_create_u32() or 
debugfs_create_u64() function would be more appropriate I think. And 
then don't make that global, but rather a per device flag.

Regards,
Christian.

>
>
> Thanks,
> Victor
>
>
>
> -----Original Message-----
> From: Koenig, Christian <Christian.Koenig@amd.com>
> Sent: Friday, July 22, 2022 4:20 PM
> To: Zhao, Victor <Victor.Zhao@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Deng, Emily <Emily.Deng@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>
> Subject: Re: [PATCH 2/5] drm/amdgpu: add debugfs amdgpu_reset_level
>
> Well NAK to the debugfs approach, stuff like that is usually a module parameter.
>
> Apart from that this series needs to be reviewed by Andrey.
>
> Regards,
> Christian.
>
> Am 22.07.22 um 09:34 schrieb Victor Zhao:
>> Introduce amdgpu_reset_level debugfs in order to help debug and test
>> specific type of reset. Also helps blocking unwanted type of resets.
>>
>> By default, mode2 reset will not be enabled
>>
>> Signed-off-by: Victor Zhao <Victor.Zhao@amd.com>
>> ---
>>    drivers/gpu/drm/amd/amdgpu/amdgpu.h         |  4 ++++
>>    drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 20 ++++++++++++++++++++
>>    drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c     |  1 +
>>    drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c   |  6 ++++++
>>    drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c    |  3 +++
>>    5 files changed, 34 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> index 6cd1e0a6dffc..c661231a6a07 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> @@ -238,6 +238,7 @@ extern int amdgpu_si_support;
>>    extern int amdgpu_cik_support;
>>    #endif
>>    extern int amdgpu_num_kcq;
>> +extern uint amdgpu_reset_level_mask;
>>    
>>    #define AMDGPU_VCNFW_LOG_SIZE (32 * 1024)
>>    extern int amdgpu_vcnfw_log;
>> @@ -274,6 +275,9 @@ extern int amdgpu_vcnfw_log;
>>    #define AMDGPU_RESET_VCE			(1 << 13)
>>    #define AMDGPU_RESET_VCE1			(1 << 14)
>>    
>> +#define AMDGPU_RESET_LEVEL_SOFT_RECOVERY (1 << 0) #define
>> +AMDGPU_RESET_LEVEL_MODE2 (1 << 1)
>> +
>>    /* max cursor sizes (in pixels) */
>>    #define CIK_CURSOR_WIDTH 128
>>    #define CIK_CURSOR_HEIGHT 128
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>> index e2eec985adb3..235c48e4ba4d 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>> @@ -1661,12 +1661,29 @@ static int amdgpu_debugfs_sclk_set(void *data, u64 val)
>>    	return ret;
>>    }
>>    
>> +static int amdgpu_debugfs_reset_level_get(void *data, u64 *val) {
>> +	struct amdgpu_device *adev = (struct amdgpu_device *)data;
>> +	*val = amdgpu_reset_level_mask;
>> +	return 0;
>> +}
>> +
>> +static int amdgpu_debugfs_reset_level_set(void *data, u64 val) {
>> +	struct amdgpu_device *adev = (struct amdgpu_device *)data;
>> +	amdgpu_reset_level_mask = val;
>> +	return 0;
>> +}
>> +
>>    DEFINE_DEBUGFS_ATTRIBUTE(fops_ib_preempt, NULL,
>>    			amdgpu_debugfs_ib_preempt, "%llu\n");
>>    
>>    DEFINE_DEBUGFS_ATTRIBUTE(fops_sclk_set, NULL,
>>    			amdgpu_debugfs_sclk_set, "%llu\n");
>>    
>> +DEFINE_DEBUGFS_ATTRIBUTE(fops_reset_level, amdgpu_debugfs_reset_level_get,
>> +			amdgpu_debugfs_reset_level_set, "%llu\n");
>> +
>>    static ssize_t amdgpu_reset_dump_register_list_read(struct file *f,
>>    				char __user *buf, size_t size, loff_t *pos)
>>    {
>> @@ -1785,6 +1802,9 @@ int amdgpu_debugfs_init(struct amdgpu_device *adev)
>>    		return PTR_ERR(ent);
>>    	}
>>    
>> +	debugfs_create_file("amdgpu_reset_level", 0200, root, adev,
>> +				  &fops_reset_level);
>> +
>>    	/* Register debugfs entries for amdgpu_ttm */
>>    	amdgpu_ttm_debugfs_init(adev);
>>    	amdgpu_debugfs_pm_init(adev);
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> index e8c6c3fe9374..fb8f3cb853a7 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> @@ -198,6 +198,7 @@ struct amdgpu_watchdog_timer amdgpu_watchdog_timer = {
>>    	.timeout_fatal_disable = false,
>>    	.period = 0x0, /* default to 0x0 (timeout disable) */
>>    };
>> +uint amdgpu_reset_level_mask = 0x1;
>>    
>>    /**
>>     * DOC: vramlimit (int)
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
>> index 831fb222139c..f16ab1a54b70 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
>> @@ -74,6 +74,9 @@ int amdgpu_reset_prepare_hwcontext(struct amdgpu_device *adev,
>>    {
>>    	struct amdgpu_reset_handler *reset_handler = NULL;
>>    
>> +	if (!(amdgpu_reset_level_mask & AMDGPU_RESET_LEVEL_MODE2))
>> +		return -ENOSYS;
>> +
>>    	if (test_bit(AMDGPU_SKIP_MODE2_RESET, &reset_context->flags))
>>    		return -ENOSYS;
>>    
>> @@ -93,6 +96,9 @@ int amdgpu_reset_perform_reset(struct amdgpu_device *adev,
>>    	int ret;
>>    	struct amdgpu_reset_handler *reset_handler = NULL;
>>    
>> +	if (!(amdgpu_reset_level_mask & AMDGPU_RESET_LEVEL_MODE2))
>> +		return -ENOSYS;
>> +
>>    	if (test_bit(AMDGPU_SKIP_MODE2_RESET, &reset_context->flags))
>>    		return -ENOSYS;
>>    
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
>> index d3558c34d406..1ffdc050a077 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
>> @@ -405,6 +405,9 @@ bool amdgpu_ring_soft_recovery(struct amdgpu_ring *ring, unsigned int vmid,
>>    {
>>    	ktime_t deadline = ktime_add_us(ktime_get(), 10000);
>>    
>> +	if (!(amdgpu_reset_level_mask & AMDGPU_RESET_LEVEL_SOFT_RECOVERY))
>> +		return false;
>> +
>>    	if (amdgpu_sriov_vf(ring->adev) || !ring->funcs->soft_recovery || !fence)
>>    		return false;
>>    

