Return-Path: <SRS0=xYMq=PI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F21D5C433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Oct 2021 22:01:08 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF6CD611CC
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Oct 2021 22:01:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org AF6CD611CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2E6BB6E3DA;
	Wed, 20 Oct 2021 22:01:08 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2066.outbound.protection.outlook.com [40.107.236.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2C6DD6E3DA
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Oct 2021 22:01:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gfg+ejoNe0N06EnrHhCZs15zy900Vh+Ect8ooF/fNIAMfm7i+EljBDw9DnVbXMgwkmS+f0S6QGMeVMqrwDVPNkiyOxbkdRGQ3YUvZitRf0EB/RXlOsX0VwvunYgjn+SUi8vnBkX6JwTFAExQcWQaJTQMOvgDYAAxwLTFLC06+Q3tB75pn89qNJ2mcOUJ4NEeMg3RP/ggBJapAw2Nriq6k/6UDMQJwP/qckg3aufADZsSLslGbZ8Ox0ECEIi/KnW3urYg037ClFIl48hMamwj+6zQeyw/aAlzyTP76O6ZFiN/JokvDsNBErfz6zAFH7MCoaiqHdBVhGZFtqs0kBf9Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NDsS4mXjO5TCBA3h5OhMkQAvyZoTf60PcjUClBNpWig=;
 b=Rq8a7e3tXYeruLJfRmMFPtxM7+3/C5LfmLCTNLjm8GYvwyrbn1pbKYqsNu3cgvDSTdgwklYU28V7pVC4hXselEmzTvNXcnWLE/oWCkQsyl2n3AQQ7cf7NgRzE6Aljs6c8+RxdRqK3KiwvkzlwI4/xmOfFk0O0QKq1k2wZot/3vuyydLe28vddBIe5GFXGXd+l1CHEFz4a8ubA/CTxTe2hM0o6PXwHniPbDK9qkprzt2FBFphmDBA4b39WMZfN/hzepRzkEPvhcJ4oqaS+rWES40Q/aZ0rFu2u1Jw16IBBw1COjKRTE6hNpkQ2sLildS5j5FwpT3QjjrufbXiK7DDDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NDsS4mXjO5TCBA3h5OhMkQAvyZoTf60PcjUClBNpWig=;
 b=tsYesXWGMoFzS6DWyKEDPtS5F/CsxefJxOSlUwnagWBBIr/s1c0ZNjDl8MLMGUFF/D1lPAH2DqkwBY/T+UiMbaKOai79Yr9SwWwT9z5zgHoP8/VWrIJG0fpeqXBQrovL/hESZjdQpIp4h29X8nS61lcMNHnoXF1hoJh3+9kMqlk=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3962.namprd12.prod.outlook.com (2603:10b6:5:1ce::21)
 by DM5PR1201MB0121.namprd12.prod.outlook.com (2603:10b6:4:56::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.16; Wed, 20 Oct
 2021 22:01:04 +0000
Received: from DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::4447:dad4:f8e9:c5f3]) by DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::4447:dad4:f8e9:c5f3%7]) with mapi id 15.20.4608.018; Wed, 20 Oct 2021
 22:01:04 +0000
Message-ID: <311fd85f-b3ab-377f-c98b-858b3afa6af3@amd.com>
Date: Wed, 20 Oct 2021 18:01:01 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.0.1
Subject: Re: [PATCH 3/3] drm/amdgpu: Implement bad_page_threshold = -2 case
Content-Language: en-CA
To: Felix Kuehling <felix.kuehling@amd.com>,
 Kent Russell <kent.russell@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Mukul Joshi <Mukul.Joshi@amd.com>
References: <20211020163520.1167214-1-kent.russell@amd.com>
 <20211020163520.1167214-3-kent.russell@amd.com>
 <42f538e2-22b7-7a74-7212-a6063694164b@amd.com>
From: Luben Tuikov <luben.tuikov@amd.com>
In-Reply-To: <42f538e2-22b7-7a74-7212-a6063694164b@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YTXPR0101CA0038.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::15) To DM6PR12MB3962.namprd12.prod.outlook.com
 (2603:10b6:5:1ce::21)
MIME-Version: 1.0
Received: from [192.168.1.14] (135.23.225.238) by
 YTXPR0101CA0038.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:1::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.16 via Frontend
 Transport; Wed, 20 Oct 2021 22:01:03 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9c145238-e45b-4d58-09a9-08d994151c5f
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0121:
X-Microsoft-Antispam-PRVS: <DM5PR1201MB0121FCFD35939472BF332CC299BE9@DM5PR1201MB0121.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QVBxw6EyV9Brcmpq4BUTlyt2FikxTjdEzpYM9GR86rys5XWN+QnatxxXc0MII7FKc7x3gEZebB9AU1RyozjdjooQQ5HsnUbri04iGkp9UYcHuPgsgR5rKHd/bp6b90FdEmGAh+lJbaSqIBw1MXKj7ff2MQBfiVTyljYMEAS0dj1ueDBh0gRINI2yR54ee0hSMWDUu7JEYoe2Igg6tsuPyHWmusS6HydiCssphBdOMyf1B6ScJhXny8OX9TxQv52mvus06qlroP4sDjEjDoAuQ787TQsx0EiErOfIbjt3j+lDNnrFHZDgip3aouuJMCh9VpbJCmdcK8uDI+pLoW96t4PdpgCMr7yoir5CTMwX8AqiBkp+SJse/Cuj2Cq9YiwUfeU2uhGJRRTtVNjnix9uHcmZ7CgaTtrvHeEWeLfmXKUE/tDeYRQeNZl4AEAYdrQdpNThHz7XEj5IuyrYpaumVZtJIyqTutAHrvD5G5lkYKmt2iJ0PfkcEllNqHz6WHNo6A6dDjv+aFvttpM3hJerPVk5mBaKmU6LzAACexSSXU8ZD2QgBftUhlaell0AbTTr+Bog+RnpTovphplw5GUv23B/jb5WGJQ0SXmwv9NMXLVvy+LNOHfrvMbvbI+UoLz5+S8W92olSYPSKNPuGmo10iT6+jb5doZRbFOYiYSuLo5C9WABRzb8yHDUn5rALUjwYbeaFVwK6e7xwkjpQLcx6D5Eig6kNP5p3BaUtRBwNXWh5IAUK9APyD8kj18lgiAB
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3962.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(31696002)(508600001)(83380400001)(66946007)(44832011)(66556008)(8676002)(31686004)(6486002)(5660300002)(4001150100001)(66476007)(956004)(186003)(16576012)(2616005)(36756003)(26005)(2906002)(4326008)(110136005)(86362001)(38100700002)(8936002)(53546011)(316002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bDJiZEFtWHpFOUNUSFNtM05uRjQ0aTJVSXNvSTVQWDJtbHkzYTNEenN5d0h6?=
 =?utf-8?B?TjVBU1BSdnN4NTg0WVdhLzhONDVqMzF1TlRDaTJld210NzNkVGhZc3phOXdp?=
 =?utf-8?B?WG5La0hSaGphL1J0b2F6ZUpQNWtjZHo5bEo1M1ZGSCtlK3JLMzRXTDNaT3Br?=
 =?utf-8?B?MHdYYTFOOU1qS201enFxdENBRC8yUGpqQmh5bjBVeksyd2JiUlU3WEQwQ0Ft?=
 =?utf-8?B?bC84UWp5ekJEcGlURnlCaTZrWkZqZlJYYUxXMy9pb2tFREN1M1lsOVNqWDJH?=
 =?utf-8?B?ODRsdEFkR0xLS1dTdEpLcmNTUVE1Mmo0YVg0WkpXMmhqRHpZclo4UTZXUk9v?=
 =?utf-8?B?Q3VWeGt0SmtDSEhBZ3d0Y2g2RGlrcUo1dFpCRXNoUytxU3NwTUVLdjFqYjhJ?=
 =?utf-8?B?aEZwNFRJWFVUZWlHWUhNckZQQUtvNWJvYzFEWEhCbWVqWGxvSlpiYWpXU3kr?=
 =?utf-8?B?bUh4MFYreHhVYytKTWJFKzdMb2R6cWdxTm5aNVF5TDRxQmFsTXl6MjhleENu?=
 =?utf-8?B?SHFXbUFvYkpRRXpuYVp5dnJha2NzYXFoSG4ybkxOL2hlWmdKUUhkN3Q0Wi9j?=
 =?utf-8?B?NnMvdnNxRjIvZnBVdzh0UFNZKzF6emZlcFI0aUE1N0FNRisyTjNPNVlpQ1d3?=
 =?utf-8?B?QThBdk41NWVwQkVEVFF3Sy9JcEVWdTJqVEM2WSt1TStYd041WHZzYkxQTjY1?=
 =?utf-8?B?YUxjWS9YYVN5cy9WZEZpWGlJZCtvM3NYWFZIYVF5ekRPL3lPcGkvclB3TmVa?=
 =?utf-8?B?VnBBWmFrTE5xVS94MUZ2WjZ0aUF0emZPUm9MeVJ4bm0va3F5MmRkb1IrOTM5?=
 =?utf-8?B?cnBKandIcm1SSTk1VmVMbmhKUXJZbTlzeWdQZXZjVWhQVlVNQTdWYmNSbkdm?=
 =?utf-8?B?RXNKSTIrSElpNGthLzFkT0J6QzFScndKNVpBZmhLS04ranEwSzRSSEVveCtT?=
 =?utf-8?B?b2NtSDFsTEkzVzRscnJwSGM4WmZKVHc0QkZKUW81TWUvQ3NJajJudlQrc29Q?=
 =?utf-8?B?RW85YlV4aC82NEo4QmRVSVpuQk8rbUlmZ0d2R3ZtQkRaS0JQRFlUTEEzVXA1?=
 =?utf-8?B?NXVSaVpxSHJQUm5vdys1bUhGOGg5ZFpQUTN4TzRJdWsvY2FaL2ZlYnRGclZH?=
 =?utf-8?B?b2drYndDYlIxR3FuQkVMT3FzbDlWTkVKTzZJUHRuZmtEWGZYdGs2bDJDYmU0?=
 =?utf-8?B?ZXJ0K2c3ZXlibjJIMkRBaUtkTEF5dWFDK09sV3VXQ3NHRnhQMXB5VGZsN2Uw?=
 =?utf-8?B?a3ZmNXViMXFwbVBnT2ozVmJMaldIcmRCSmloc1NCUjhidW9Mc04xb21XZ1c4?=
 =?utf-8?B?dE4vRktFMjRYeHpYL2NKY0dIdzlyVGs0S0k0MnlUVnUrTldsQWkvdjFtbjIv?=
 =?utf-8?B?WnQ3R1lGZkhMNFZwRGdYL054dVlmd3RDTzM5aG5YZEdsdllQZENqSFVMdENm?=
 =?utf-8?B?b3FpYWZiY2ZMY2lOUWJoOGFwdGFEVzlZZ1ZFcUFpZXc0bWN1d0tENWN0a25D?=
 =?utf-8?B?c2JuYXUyaHA4YWM4TnFXN2FyeGtOSzl3QkxYL2hQcnBSRi9Rd3NIYm5QZ1pj?=
 =?utf-8?B?NVFWeG14VmNKeGJLVUNIRkZxNjdaeTJQbUtzMW1SaDYrT2pQSy8xTHgrZ0sw?=
 =?utf-8?B?cytnc2hwQk9UcXlKMUNqeTRXcGtiNkRpQ0J0Y1RiRDBhbVpmWjh2dStvdCt0?=
 =?utf-8?B?ZUNDZ2gyT2ZsMTN5a3FoK3d6ZG1HbE10Z1pSWWdXc3ozS1BTcmVJZllIREEx?=
 =?utf-8?B?eXhUb0xaMnVoNE1pMGp4T1dqRjY2eEpCVG1kZTQ5WW9JcVpDYm4wblNrMExQ?=
 =?utf-8?B?Q0JWS3d2OFF6S2xTUnVEL3lzMzZTbTZRSzNzUTRZZmthclR1ZitwbSt0bEhN?=
 =?utf-8?B?SFJkeWtOeE05SVRjeUxja3ZaejRlSkdPcXAySUxUQzU2d1NSWExVdkdYY2cv?=
 =?utf-8?B?NFBTUFRxK213bC9OREp6ZGVLbWJrcE5pUHduVjRmZGtzeVpFakxnL1pKWSsy?=
 =?utf-8?B?WjNodWM2UkVCV29JL2luRmZ1dzhPUlNBa09GVWxvQzROQng4djV4eHlEL1JH?=
 =?utf-8?B?VVdlSnVESFp0R2I3QUg1N1A1UVQvNDVXSGN0OTg0RjNOY3E3MnZYZFpQdmxC?=
 =?utf-8?Q?7nds=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c145238-e45b-4d58-09a9-08d994151c5f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3962.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2021 22:01:04.2419 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jhEtj53G3+Ymada5dWUN+6D3uXGw7S+DZYlD5jbDeSDHuNW7OKLohSvuoPX8dIPF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0121
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

On 2021-10-20 17:54, Felix Kuehling wrote:
> On 2021-10-20 12:35 p.m., Kent Russell wrote:
>> If the bad_page_threshold kernel parameter is set to -2,
>> continue to post the GPU. Print a warning to dmesg that this action has
>> been done, and that page retirement will obviously not work for said GPU
> I'd squash patch 2 and 3. The squashed patch is
>
> Acked-by: Felix Kuehling <Felix.Kuehling@amd.com>

I was just thinking the same thing. Keep the title and text of patch 2 and add the description of 3 to 2. With that done:

Reviewed-by: Luben Tuikov <luben.tuikov@amd.com>

Regards,
Luben

>
>
>> Cc: Luben Tuikov <luben.tuikov@amd.com>
>> Cc: Mukul Joshi <Mukul.Joshi@amd.com>
>> Signed-off-by: Kent Russell <kent.russell@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c | 13 +++++++++----
>>   1 file changed, 9 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
>> index 1ede0f0d6f55..31852330c1db 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
>> @@ -1115,11 +1115,16 @@ int amdgpu_ras_eeprom_init(struct amdgpu_ras_eeprom_control *control,
>>   			res = amdgpu_ras_eeprom_correct_header_tag(control,
>>   								   RAS_TABLE_HDR_VAL);
>>   		} else {
>> -			*exceed_err_limit = true;
>> -			dev_err(adev->dev,
>> -				"RAS records:%d exceed threshold:%d, "
>> -				"GPU will not be initialized. Replace this GPU or increase the threshold",
>> +			dev_err(adev->dev, "RAS records:%d exceed threshold:%d",
>>   				control->ras_num_recs, ras->bad_page_cnt_threshold);
>> +			if (amdgpu_bad_page_threshold == -2) {
>> +				dev_warn(adev->dev, "GPU will be initialized due to bad_page_threshold = -2.");
>> +				dev_warn(adev->dev, "Page retirement will not work for this GPU in this state.");
>> +				res = 0;
>> +			} else {
>> +				*exceed_err_limit = true;
>> +				dev_err(adev->dev, "GPU will not be initialized. Replace this GPU or increase the threshold.");
>> +			}
>>   		}
>>   	} else {
>>   		DRM_INFO("Creating a new EEPROM table");

