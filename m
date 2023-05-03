Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C7ADC77B75
	for <amd-gfx@archiver.kernel.org>; Wed,  3 May 2023 15:09:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C24A910E2EB;
	Wed,  3 May 2023 15:09:09 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2059.outbound.protection.outlook.com [40.107.243.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6C7BD10E2EB
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 May 2023 15:09:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AcLS2il7aHmSxUAfqHPI04s53z9bYPjKz/1xxqCSfuc7N0EjfsKUmMn53mH1iSeXGh6FZFOxujf9KQ1cfJDQZo7BjgPlBResnTBrLFeeMfKf4RG2heU3rRrgL+quMYaQlp0KeBOO52WIbh1IzA+dYgqAHM2k7eI45n8KfwqVHQQlaEhq3Bxd46cCWCnrN6U7fZqXxKxjGCGHCYp/W2Tkudl8AEQJty4U0Et/Ib+aDQzc1qCt+RKQJgvaqZX1WmVE/SPojXJwSVJw8rPXIgvGHJpV08gNHS0bpkZci8cnhPPyoxZgSE0fLPpNL9MS9UlUVsK29UQit7fBXaH7LmTxBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g2mBatpjTrGVBe0zi0w7eNRjPfk0d+yIQE03ZjUtGN0=;
 b=NGbiBrh4mhw4P7sesRcFEP3V63AJEZx58i8F+BQgkp9qL8BqVokRbyLt+bS5aw5WVqqm1ovpDr2jSomNyla8zx783Qnrckn2i6nZYE+yI0N8j4E8jEr1CbBGaTULFcuEJaYYaVjXl/WK3798hFHN0rnXbcz7CJgGTsNKlnrKJeULH3qMqBwfUDj3EkBCzrFd0xIqau80vb7odnkjR/rQROEAmfaMDJ+9fpWM140FbDdMxBYgmtS+NsRM9KivuELZvF71/bpHzrED4mSKPFhW6r9NWOlSUOp1XBHCo5D9p2jXyRTvl5BFPGNRBN1cGVxAW7e3xWsG4xudZGxwlKjpFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g2mBatpjTrGVBe0zi0w7eNRjPfk0d+yIQE03ZjUtGN0=;
 b=bvYLnbPVUQDv6v62+OO/NnWsxl7ZHO5SlbUX44cJvkWfRQg9YZfvBOM6/sKs5rtTv4dMRXxMoAn982YmLaQ0INE3ck12s5jvrnSmNJoNZAqm12CrVsHEo/ktjBNYXyhcHXA22HneZb+iBM6XC+JLZ6rbWxZ1o2K29uvdARJ0des=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3370.namprd12.prod.outlook.com (2603:10b6:5:38::25) by
 SA1PR12MB7412.namprd12.prod.outlook.com (2603:10b6:806:2b2::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6277.34; Wed, 3 May 2023 15:09:05 +0000
Received: from DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::8299:158a:c296:de80]) by DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::8299:158a:c296:de80%6]) with mapi id 15.20.6363.022; Wed, 3 May 2023
 15:09:04 +0000
Message-ID: <598e9818-b28e-e230-b920-29729dd9acf0@amd.com>
Date: Wed, 3 May 2023 11:09:01 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH 2/2] drm/amdgpu: drop unused function
To: Alex Deucher <alexdeucher@gmail.com>,
 Alex Deucher <alexander.deucher@amd.com>
References: <20230427183429.599578-1-alexander.deucher@amd.com>
 <20230427183429.599578-2-alexander.deucher@amd.com>
 <CADnq5_MAiEcCAE79NoeC5FU9eh+kgYBjD0azagRyaDvuXSEGcA@mail.gmail.com>
Content-Language: en-CA, en-US
From: Luben Tuikov <luben.tuikov@amd.com>
In-Reply-To: <CADnq5_MAiEcCAE79NoeC5FU9eh+kgYBjD0azagRyaDvuXSEGcA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQZPR01CA0098.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:83::17) To DM6PR12MB3370.namprd12.prod.outlook.com
 (2603:10b6:5:38::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3370:EE_|SA1PR12MB7412:EE_
X-MS-Office365-Filtering-Correlation-Id: d7b62b71-6a0f-47af-2e55-08db4be85592
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: U7ZXfRtKmn131cE/zibtEosbFNguPemSAQ4m1XCspasoX1uIT/EEcjucq15IB6aMNHSC94hJSy+gt1YooPTs+pCpBeealad99klubg9TL9kTk0oyn7j3R/1O/K5/gdJPQBwAiDlwoqU5mqqRYdUlFjVKJvaYylpvsysQDDM9zp8eiVJAUUvNycw+bM+uWisLpS8gUdZLyv+5aolLI4cjSXlD9BF9nM/ZNzYjP1ECVb+7XXLvcYOTHxixUrcY1X8zE84G72knisXOv5xrwmp5VCyU5OfnnXI15ksmySd4Whg3j6mXEW66mlQrbAAzE4YcHiOxcmfB02ZAl2uYEfIu1C6Uex1bX8ZEvVgb2vHc6DkG/SjP65VK8gcUlzFW4tkBkwuekVTgj2zG95ULB3U3Q67gHFWCadjFBm9P6323+8LUHiddJ0BUfYG+jWnuZqturE9AdsCyDoI89nTCSZPrOgcJQW35SN9SSrqNt3m62CnnR5WCdqjzSCJ6AgyrTEhrH6EPYfwYPsmzJOhxONDvrGlvU5jhHvyNqWVVfJM45feN5D3Eyvh3Q5PweLr/6eMvVHl3ZiNtZh3ZUc9QNfW+1O3jQzwcEPD5l0kfvVUe5iyFE/F+4ldu8PHNUUKkcNPpggZhCXjUV+Z6g+/3EL9tSQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3370.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(39860400002)(136003)(366004)(396003)(376002)(451199021)(31686004)(186003)(6666004)(26005)(53546011)(6512007)(6506007)(2616005)(8936002)(44832011)(66946007)(6486002)(66476007)(66556008)(4326008)(5660300002)(478600001)(8676002)(6636002)(110136005)(316002)(36756003)(31696002)(83380400001)(86362001)(2906002)(41300700001)(38100700002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L01sSXYzWGRuUk5qdGZNaXBFcHNleW1iN1VHdXEveFZDWTZsdGdCRFBIRzdY?=
 =?utf-8?B?eHM0MFd0MFVLVVZvUXdYNnlCanJUWTFNakx3ME5WU2c5M2ppNVUvbHdLL3kx?=
 =?utf-8?B?MHBhYmQ0WkVwK2FodVRRdlFGMUtNNzhYRVFjNFlZMUxyL2tLb3BPSlhhUnYr?=
 =?utf-8?B?YytHM1d3UU9tdDM4NzRVaGxsa3RWZld2aXlBWmFDSGg4cFlrN0IrN3poU3lL?=
 =?utf-8?B?dExZN0JqRTZ4bmZlTTh2L040Nnc2cjMwdVJMYzFydE90a042ejlaRUtkamhw?=
 =?utf-8?B?SDUwSU9vb0wwVEdpYll5a242bndBRytpVnlMeCttb1Z0NlNEemVOcVV5QnRs?=
 =?utf-8?B?NGlNQ1ljNnhtbG9JUThXamQzSkhubFkvanhnYklIc05IcFMrUGNEaGt6RUZk?=
 =?utf-8?B?aXBQY0xpcGJMYVVHN0pKclRJRlovaG5SVkw4YThLbDNBSTVRVzFpUXBNR1FU?=
 =?utf-8?B?dE8ycHF1b3EyRTVWSG52Smd0VjM5ZTBNTHR3Rmk1MFkxWnR1WWpVSWlWL00x?=
 =?utf-8?B?MHNqZS9FalR5YWpNYkgrcTVHUnRVUDIxTnU3Y2lGSDI4MnZ0T1I1bHZUOEsw?=
 =?utf-8?B?MVdFMEpURUNNaUR6WW5HSVR2ZTg3QlJsL2dNQVVSZi9VRlZ5eEtEcUdSNUp4?=
 =?utf-8?B?QnV4TTJ1Skxub0xaLytDN1I4bllVdjI2R0FSdGZ0YzBVVFUwcDlFUHdsMy9X?=
 =?utf-8?B?dFowbElhbWp3SzBITFNMcThmUmk3YWVNcFBYY01OeVUyT0FMVnIzaEgxc2g2?=
 =?utf-8?B?TGdXa29CaWgzWndPSUJqS3EwbVBjSUFMdnFtNllhMGxhd09lZlBkZTdEQWds?=
 =?utf-8?B?Q2gzdjFjcm5xVE13SmREZkhIcHd3bGhKNWtvWFRYdnZ6Rzh1VGpZZlJYRTl5?=
 =?utf-8?B?dVUreldsbEJXbzVadWJwVEEzZkdCcXEySDNGbVZmUTQxeTV2NEZnK2NsMC9R?=
 =?utf-8?B?ckFFbEtSakplN2V6VkdKUHVSMXU1V2VxTGMvdVRLTVVLbEs2QnFkWFpQcUpL?=
 =?utf-8?B?Q0pNVDZvQkxpTHppZzFLc2VGTHZQaVh3cmU0cmVGOHRONmJadkgrWXg2N3RE?=
 =?utf-8?B?dm5mK0lxTUg5K25mSXJYODVGeTRBSlNZbitIbXlQUUMrWGpaOVd5Uk1rYXpP?=
 =?utf-8?B?TEZhd1NSdVJaNCtweHM4SDVqOWIrVTNuR0NVS1p2NUFwYjRjbUhKcS9acXNw?=
 =?utf-8?B?Y1YxdC9ackNPR09MWjEvNnpabEI1Vlk1U1JSZ0F4eXNvSXQrY1pwY0lmb2Uz?=
 =?utf-8?B?RmFMQXdYMVJ0bSs5bGFKTDRGV3kxMEFYWEFNa0FYa2NUT1cwZncxcytwcVVI?=
 =?utf-8?B?VnlIKzdab3lCWlJzUGVKOW1DOGV3UmpoTHhBQTUrRVZhYWZtNUNDb1ppUkcw?=
 =?utf-8?B?S1FpS0N1Vjh0UmRldVlQRXZWYUJMdUVob1JYTm1sZWtaQnB2V1BmUkdSa0Va?=
 =?utf-8?B?WWhObTJwVk9yd1ZwTnY4WVk3ZEg0Z1JVbTY5dy9qb2pidFR6dld4djMwWlQ2?=
 =?utf-8?B?YXYvdGtQNFk4K0FSeUphczg0bmQxTXRteWowckRrYWhISG9XZWxkcXJSZzlu?=
 =?utf-8?B?WW1JY1hsaFRNeFVsaTVPNll3bjhiUis1eDZIWXJ5YXRGUFYyc1BxNk0wS2d0?=
 =?utf-8?B?NFhDVmIzcXcwSHVId0pzS2FRRUY5OGxIak1EVmc3OWRSY0swSEpDSHNLZThG?=
 =?utf-8?B?TTR1L0g2ZEFnK3VHa2dTT0c1b0YrdnZKKzRUSUdtSVJNcUNqaVNqRVM5MHg2?=
 =?utf-8?B?cXQyamhqYW9aYXMwTHJlTGU5dG1IR1Y5S1gxc0R1MjlIeGpvMys1S0FFOC9N?=
 =?utf-8?B?aXorMUlVODh6OVlCendsSVJWV0ZMUUZPbVZLOENhd3Jtb29lYUlMWTdXQ0tz?=
 =?utf-8?B?Y1lXRDJ5cEF6aHBVVzdBYXoyYTRQSHk4cXBSK3doamMrQUNmZ3ExODJPSkVG?=
 =?utf-8?B?eWJ4UFE0OUpRcnNrRG1LekpYWlVKTFBvQVZTbzFLOWduMEJWSjRKMnFaWkNw?=
 =?utf-8?B?ZFJ3dmdjNG5iQkdNZWFtdjBZSytFQUpmcUtBblVFOVNXRm5aTnZFYUFLTmVE?=
 =?utf-8?B?NW9VVWNEZHVyd2VPTHNFVGRocGRWOXRoMkw1azlaTW4zd2pwemhDK3NyU1ZF?=
 =?utf-8?Q?zTdGC2Q9IQxru3Y0oCVuyKdN/?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7b62b71-6a0f-47af-2e55-08db4be85592
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2023 15:09:04.5381 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ytW5OJLt4U9xhcgcxNz4lPJrHP13T7ZUbJGVBtAM20LQ8D4+5Ky+dZ4yV3Tq/wh7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7412
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

I suppose we have this information elsewhere.

Series is:
Reviewed-by: Luben Tuikov <luben.tuikov@amd.com>

Regards,
Luben

On 2023-05-03 11:02, Alex Deucher wrote:
> Ping?
> 
> On Thu, Apr 27, 2023 at 2:34 PM Alex Deucher <alexander.deucher@amd.com> wrote:
>>
>> amdgpu_discovery_get_ip_version() has not been used since
>> commit c40bdfb2ffa4 ("drm/amdgpu: fix incorrect VCN revision in SRIOV")
>> so drop it.
>>
>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>> ---
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 48 -------------------
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h |  2 -
>>  2 files changed, 50 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
>> index 76ceca05452e..b58d94dc1924 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
>> @@ -1208,54 +1208,6 @@ static int amdgpu_discovery_reg_base_init(struct amdgpu_device *adev)
>>         return 0;
>>  }
>>
>> -int amdgpu_discovery_get_ip_version(struct amdgpu_device *adev, int hw_id, int number_instance,
>> -                                   int *major, int *minor, int *revision)
>> -{
>> -       struct binary_header *bhdr;
>> -       struct ip_discovery_header *ihdr;
>> -       struct die_header *dhdr;
>> -       struct ip *ip;
>> -       uint16_t die_offset;
>> -       uint16_t ip_offset;
>> -       uint16_t num_dies;
>> -       uint16_t num_ips;
>> -       int i, j;
>> -
>> -       if (!adev->mman.discovery_bin) {
>> -               DRM_ERROR("ip discovery uninitialized\n");
>> -               return -EINVAL;
>> -       }
>> -
>> -       bhdr = (struct binary_header *)adev->mman.discovery_bin;
>> -       ihdr = (struct ip_discovery_header *)(adev->mman.discovery_bin +
>> -                       le16_to_cpu(bhdr->table_list[IP_DISCOVERY].offset));
>> -       num_dies = le16_to_cpu(ihdr->num_dies);
>> -
>> -       for (i = 0; i < num_dies; i++) {
>> -               die_offset = le16_to_cpu(ihdr->die_info[i].die_offset);
>> -               dhdr = (struct die_header *)(adev->mman.discovery_bin + die_offset);
>> -               num_ips = le16_to_cpu(dhdr->num_ips);
>> -               ip_offset = die_offset + sizeof(*dhdr);
>> -
>> -               for (j = 0; j < num_ips; j++) {
>> -                       ip = (struct ip *)(adev->mman.discovery_bin + ip_offset);
>> -
>> -                       if ((le16_to_cpu(ip->hw_id) == hw_id) && (ip->number_instance == number_instance)) {
>> -                               if (major)
>> -                                       *major = ip->major;
>> -                               if (minor)
>> -                                       *minor = ip->minor;
>> -                               if (revision)
>> -                                       *revision = ip->revision;
>> -                               return 0;
>> -                       }
>> -                       ip_offset += struct_size(ip, base_address, ip->num_base_address);
>> -               }
>> -       }
>> -
>> -       return -EINVAL;
>> -}
>> -
>>  static void amdgpu_discovery_harvest_ip(struct amdgpu_device *adev)
>>  {
>>         int vcn_harvest_count = 0;
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h
>> index 8563dd4a7dc2..63ec6924b907 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h
>> @@ -28,8 +28,6 @@
>>  #define DISCOVERY_TMR_OFFSET    (64 << 10)
>>
>>  void amdgpu_discovery_fini(struct amdgpu_device *adev);
>> -int amdgpu_discovery_get_ip_version(struct amdgpu_device *adev, int hw_id, int number_instance,
>> -                                    int *major, int *minor, int *revision);
>>  int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev);
>>
>>  #endif /* __AMDGPU_DISCOVERY__ */
>> --
>> 2.40.0
>>

