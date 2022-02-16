Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAF69C433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Feb 2022 10:43:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 381AF10E344;
	Wed, 16 Feb 2022 10:43:31 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2085.outbound.protection.outlook.com [40.107.243.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CDC3E10E344
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Feb 2022 10:43:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HW2fzqOw0yltpSVA2Wy7nN5soFcimakJjUhsUCeFlFP3t3FDHHA9BaWV/LO9T8ORhC8WCWLsOwrqG4jqQX6+buks7T4gU/G/hNB6uKz+diVXYwb7MmC7OaGdPRndBJjFeecKx1gtBOsqHCrh1FwwVOLj4wcrSssF0Gpe9+AqEkWc4tjV6EjD0wnuLOhCfWyJt9D9GpQTZVIhLEiv7ev2NzIuS6HIPY4s2j2/ekaMipuGVOAewZNAeOKbv/N11+ufotoxledqYlguJS+DhIq2Pkdi7VB3xPlmViSjVpHr/MyPEfhPLICCwyzu53qI/Ac6UKEnvCDavvtk7751j1+8+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HrNuaBcF/UT5/MqDcWucZcnZI5OfTzMlQeixQtnPD1w=;
 b=QgsfHykHVjz8pSAeMDYvj1HvSevjRFzzsolUDfvpJmgOKNAEJ83l7I17zg0plJ5XqILbnw5DOww4rb87vfrGq7PLv0y7P8VvrYpzd9R9g6rBqGz1wDQbl9RvDqRhOIUcVvkFf6wKoXJxNFl1Phaj2vhWiGTETYX1CTT9rBdfvL2TU/RmLE48ExlJzU3TNluCBrNdiE27hfRVzFDDwV4W0aldsiyWEIYwSTuDzUlR/PvLxwsvRnDrbQ2OwRuh2/2BOD7aj7KnpX6bHaVEA/SVEOwx5E7ado5WonMy3yoElp7SP+WGtZ0v+Zg1V7y2HKAH820Lw+i0KF5QXiv3XczvYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HrNuaBcF/UT5/MqDcWucZcnZI5OfTzMlQeixQtnPD1w=;
 b=FTLk0GGb0JcH8gCbLz+ji2xYouTEr007JgIyoTZSxY2ngfZO5POVTi/kA/i2ckV1d0qow/xfLXWXEQYB8YJstoydcAdt65agE1YsWRo/WGU1wCntNYdNcFjc8RwRFW5Cqa2uA5GvsSQZD6fF4W6oYtaX/5BgrLsSBInwc3ic1s8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by DM6PR12MB4747.namprd12.prod.outlook.com (2603:10b6:5:30::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.16; Wed, 16 Feb
 2022 10:43:24 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::bcfd:825e:23e7:698c]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::bcfd:825e:23e7:698c%7]) with mapi id 15.20.4995.015; Wed, 16 Feb 2022
 10:43:24 +0000
Message-ID: <1021c2e4-22bb-1e94-1a91-c4d7cd915b49@amd.com>
Date: Wed, 16 Feb 2022 16:13:09 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH v6 1/2] drm/amdgpu: add debugfs for reset registers list
Content-Language: en-US
To: "Somalapuram, Amaranath" <asomalap@amd.com>,
 Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20220216094949.3169-1-Amaranath.Somalapuram@amd.com>
 <fa563eb7-a0df-cbda-004c-23b10e882a6b@amd.com>
 <392e1b15-8bbc-91cf-ab86-9d28aa0b716e@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <392e1b15-8bbc-91cf-ab86-9d28aa0b716e@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0116.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:96::6) To BYAPR12MB4614.namprd12.prod.outlook.com
 (2603:10b6:a03:a6::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8685c6f0-6512-4214-3c2d-08d9f1392811
X-MS-TrafficTypeDiagnostic: DM6PR12MB4747:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB4747C8C913B8BE368A6DB18397359@DM6PR12MB4747.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TobS+BFaoeirOxTN/SONvW0vl2B13PIWsF3Pk36TIt5mJPM5qkR7W/puXPWjQZ38aKLSe6o/eiJ8BBpC/v51bV6Wi+biuQ3PbiqPvnc/E0p80xYAgevHeLsrcYGydH/TQR8H95APuExaB7MjN49GZ5vk8E2m0k9TrHFBO3f3UL9Y4uPT7yfbtG7Cbn8alCZtMKOz8UguzmeZp8Zbpx9VVqVo2sXoe1oukbd/ZHyvLdktjm7W+YkE77KWS1mkBQpClflQrFXGKoVgJC65xqbEKIIodavgNaVj8r3EVXQIuZ7m1HYcerChgrHZeD/AF+5R8hxn2zMc0LdiA7+y87OrbihMxlHEoxraNnHEzKRAXgDEpBt0Zrrho4c/PkQFOZTrNdbR8GhhW0Yn1q+egeOPNpIPZuOUIs6CiEUSJTqRBQdcykSYMUxZz0biUGv/pZimvB+CyEOJOZwXsDNurx4/go3Zt2tKO4NF6/5CA/toZRAPVlNGfOOmOW6HU2WsGWb7XkKRyscC0SVjWJWeGxZkOcBHK4CiDsc1+VKK8t7+MVFR6o2lQxeT8RIRvlxCOCfUa0JLi45taNxEWiksGItMSWJW/sI6hn1oD/JsYKlMB2Mw4nL88BqxTlFPVFFMYeEJmME2AWt4V9C0RCW0NMgjdjCWopckT68DS1S4M/hEpuG5clIC+RqsAISUdfzbLqFgGA8UmEH4PvG5t1gC3NqNEI4xrUhPlMkJYN4KuLblARLd9E6v+xRGWVkWI5aMPjvv
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(53546011)(6506007)(8936002)(38100700002)(86362001)(31696002)(2616005)(2906002)(26005)(186003)(36756003)(5660300002)(6512007)(83380400001)(31686004)(508600001)(6666004)(6486002)(110136005)(66476007)(8676002)(4326008)(66946007)(66556008)(316002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UzhNR3VhVG0rNGxlcm1vK3V1MTRtd1ljOEl0Q0JBV0xFTVBwcUdFMjgycm9G?=
 =?utf-8?B?OGxkc292ZmQ1TmtxY0tQMmpCTTJrTWlrVTV6OHZKdFFjMm5FL1pCZzlvMkwr?=
 =?utf-8?B?U0xlUWkxb1JhZTBRcE5VdEorRlhVb0NVR2cxbStZNnRER0ZManhHNE53M1Mw?=
 =?utf-8?B?S1RHeGRrSDM1QVhDeisyRzZFWElmT2ZGSlRqQUN3Q1NhdVZGYkhjSGl4Z01w?=
 =?utf-8?B?a2xFd1ZtY3R4dXlmbjY5cERtbDZYa3BmcHRobnZabjRWL1dPVGdicHFFdlIr?=
 =?utf-8?B?NkNSdGNGRjN5dnZvVmJwRFBhZ3dJdkJ2TE0zQ1RXZFhRNE9xTjF3WVd4VkJM?=
 =?utf-8?B?ZHByN2hOb1luVGRHbzhRNVk4SXJyS2FWSStrcnlyOHRtcGFrTDM3WGFNZ3RC?=
 =?utf-8?B?SlhBby9DR3Zib3dhMmdqaXp4UUxEc2dwUzVBS1dHaDlmZFRYRjFnbmhSbVVZ?=
 =?utf-8?B?a1NjdUFnb1k1aVNtWDI3ZnJwbWVLZHJXUWt5Wmo5eFRJNmxlSE0zNkxBS3U3?=
 =?utf-8?B?WnR6d2ZaNU1HcGZwblJaaXhKTWFPTWtVellnbHRlRFVVSDRZM245bUljMHZK?=
 =?utf-8?B?Q3UrMCtDb1VhMmE3TjlDTDdhbWlDekhhTzUzckZ3aXJ3T0lzbXAwYXYybi9E?=
 =?utf-8?B?MTdTUVQ3cHNaNmhWMzR5T3pyLzRiMUUvL2VZL0tmTXdaR2ZQdklnd1NrMkN4?=
 =?utf-8?B?ZTd3QmxhVmlabHlaOHRhdk9OMnIzWHlmUDduTmZYcGxOT0VXQW1MTEFwaDc4?=
 =?utf-8?B?OWlsM2lMazhhaUpaUUZKU1htUTFLZXZqMGtzVWFScjdoUy93TDhGV3VHN2NB?=
 =?utf-8?B?TlB4U29JK2R2SW11MlpSNnpsQ3VaUkkrMHhZeVNBa0doaDZGKzJOTE0wNTNp?=
 =?utf-8?B?K2g0TTdnaE9OMTZTSVUrbTM5N1V1YVhZeSsvcUw2dHNzZWFxNkV6VGp5dGt4?=
 =?utf-8?B?bkY2bkVCNU9TWDNpR2FzOG5hNnVwUk9MeU1jWTZHbk9HYWRDK0JrK0pEWEY3?=
 =?utf-8?B?SXVJOE5tdEthMm5qSTJVd0d5T3VyU0FpN3ZlMlJVQ2ljM3h2TXpkZGpSV1M5?=
 =?utf-8?B?RTVIcWRFemVqZTJFL3EwTHZ4Vnk4QU9IbEduSkxMaHFlM2VHcFIra25FeFJO?=
 =?utf-8?B?eTE5bzlGL29WQ1Y5WU1ZZUlGR3dHMzJseGRxUzZVSzV0bGpqSnAwaWJTRWJm?=
 =?utf-8?B?ZTBrS2JTcGV2WEtZbklEV0JZOG1rMHZvQ0JjUjZWaXBQcXRjZWJOZEFyOG9p?=
 =?utf-8?B?SVVSQnlIb0IybGVvRW9jZVhYR2lJbFJDaCtDS3JDTExEL01uM0JZbFoweGNj?=
 =?utf-8?B?Y0lScWdzMzVnazFkcnJKaktEYlBVYnRYTDhiL1p2SUdQdkhKUnl3ME5KZTFl?=
 =?utf-8?B?U0RCODRQa1VoN2l1cmNWNmkycUIyRHpwUDRXQkd5UjlYUHI2dXJqSkZ6Q3Nm?=
 =?utf-8?B?N1FqZFpkcU84TnptSHBtN2JaY3gycGZuR1dZdk5LY2RkZ1krcnRjWFFuSFJs?=
 =?utf-8?B?OWk5anBSVDl6dmQ5TTNsaWk1ais5WXhJYkpwMU5SQVFVZnlGWmN2YXBxa1ho?=
 =?utf-8?B?MVA2aFNYanVjakNtMmI2VUlva2RQa3JSZW9HTWc5YWFEM2xpWkpKZGgzNHNY?=
 =?utf-8?B?YTZCempVM0dNdTJUTUc2bVFjVGVmMlJROElzMXI0dnRlbEZCRWNUU2hNMzVC?=
 =?utf-8?B?Ulg1UGJkVlVlcUJ6K3NkZTdTV1ZLa2k5clU1YzhIRkxydGlvSTNDa2VaMUh3?=
 =?utf-8?B?U3RCVEsvL3ozVjZXWDMxd3BBbTYxMFB2ZVhBQVBhM09KTWNRYzl0Y1hTWHBY?=
 =?utf-8?B?SERzaEZYdVg4Y1MybEE1em9wQUFJMTRpWDczVSt2endVOU5STW82N01BNjNF?=
 =?utf-8?B?cnlEMkovLzFzTy9XTUR6ekVra0haY0VzYzRCc1dOSzdSQy9kTU9PVHAwaks1?=
 =?utf-8?B?ZVNvRXJjRWVZc1Q4bEpTS2VpaHFFQzhJcy9Xc21hZXV0QWsvTVh1TlVCYy8x?=
 =?utf-8?B?OEF1MVgxTk84ZUdHSjNBRkh5UnhFbVdxTGVteTU3R3hDTTNheUc1VjFGVGFE?=
 =?utf-8?B?ekFvOGp1OGo1cmIyZVdVSUI4dnhyMHQ5WXlmNUg0RE1tZnJwanpjQjE0cWZR?=
 =?utf-8?Q?vmvY=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8685c6f0-6512-4214-3c2d-08d9f1392811
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2022 10:43:24.1033 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KvFbNjHhN/pBUvW7jxsOyvXlIy84C4xD5o4gPa9xp55RBo3gCfDrOzBTLlCC+ozx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4747
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
Cc: alexander.deucher@amd.com, christian.koenig@amd.com,
 shashank.sharma@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 2/16/2022 4:04 PM, Somalapuram, Amaranath wrote:
> 
> On 2/16/2022 3:45 PM, Lazar, Lijo wrote:
>>
>>
>> On 2/16/2022 3:19 PM, Somalapuram Amaranath wrote:
>>> List of register populated for dump collection during the GPU reset.
>>>
>>> Signed-off-by: Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu.h         |  5 ++
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 95 +++++++++++++++++++++
>>>   2 files changed, 100 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>> index b85b67a88a3d..57965316873b 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>> @@ -1097,6 +1097,11 @@ struct amdgpu_device {
>>>         struct amdgpu_reset_control     *reset_cntl;
>>>       uint32_t ip_versions[HW_ID_MAX][HWIP_MAX_INSTANCE];
>>> +
>>> +    /* reset dump register */
>>> +    uint32_t            *reset_dump_reg_list;
>>> +    int                             n_regs;
>>> +    struct mutex            reset_dump_mutex;
>>>   };
>>>     static inline struct amdgpu_device *drm_to_adev(struct drm_device 
>>> *ddev)
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>>> index 164d6a9e9fbb..faf985c7cb93 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>>> @@ -1609,6 +1609,98 @@ DEFINE_DEBUGFS_ATTRIBUTE(fops_ib_preempt, NULL,
>>>   DEFINE_DEBUGFS_ATTRIBUTE(fops_sclk_set, NULL,
>>>               amdgpu_debugfs_sclk_set, "%llu\n");
>>>   +static ssize_t amdgpu_reset_dump_register_list_read(struct file *f,
>>> +                char __user *buf, size_t size, loff_t *pos)
>>> +{
>>> +    struct amdgpu_device *adev = (struct amdgpu_device 
>>> *)file_inode(f)->i_private;
>>> +    char reg_offset[11];
>>> +    int i, r, len = 0;
>>> +
>>> +    if (*pos)
>>> +        return 0;
>>> +
>>> +    if (adev->n_regs == 0)
>>> +        return 0;
>>> +
>>> +    for (i = 0; i < adev->n_regs; i++) {
>>> +        sprintf(reg_offset, "0x%x ", adev->reset_dump_reg_list[i]);
>>> +        r = copy_to_user(buf + len, reg_offset, strlen(reg_offset));
>>> +
>>> +        if (r)
>>> +            return -EFAULT;
>>> +
>>> +        len += strlen(reg_offset);
>>> +    }
>>> +
>>> +    r = copy_to_user(buf + len, "\n", 1);
>>> +
>>> +    if (r)
>>> +        return -EFAULT;
>>> +
>>> +    len++;
>>> +    *pos += len;
>>> +
>>> +    return len;
>>> +}
>>> +
>>> +static ssize_t amdgpu_reset_dump_register_list_write(struct file *f,
>>> +            const char __user *buf, size_t size, loff_t *pos)
>>> +{
>>> +    struct amdgpu_device *adev = (struct amdgpu_device 
>>> *)file_inode(f)->i_private;
>>> +    char *reg_offset, *reg, reg_temp[11];
>>> +    static int alloc_count;
>>
>> This being static what happens when it is called on a second device?
>>
>> Thanks,
>> Lijo
>>
> I tried to avoid adding to adev. It wont work for multiple devices.

Hmm.This is not friendly for single device also. Some one could just 
parse a text file of reg offsets and do
	sudo echo offset > file

This will overwrite whatever is there. Instead you may define a syntax like	
	sudo echo 0x000 > file =>  Clears all
	sudo echo offset > file => Append to the existing set.

Taking all offsets in one go may not be needed.

Thanks,
Lijo

>>> +    int ret, i = 0, len = 0;
>>> +
>>> +    do {
>>> +        reg_offset = reg_temp;
>>> +        memset(reg_offset,  0, 11);
>>> +        ret = copy_from_user(reg_offset, buf + len, min(11, 
>>> ((int)size-len)));
>>> +
>>> +        if (ret)
>>> +            goto failed;
>>> +
>>> +        reg = strsep(&reg_offset, " ");
>>> +
>>> +        if (alloc_count <= i) {
>>> +            adev->reset_dump_reg_list =  krealloc_array(
>>> +                            adev->reset_dump_reg_list, 1,
>>> +                            sizeof(uint32_t), GFP_KERNEL);
>>> +            alloc_count++;
>>> +        }
>>> +
>>> +        ret = kstrtouint(reg, 16, &adev->reset_dump_reg_list[i]);
>>> +
>>> +        if (ret)
>>> +            goto failed;
>>> +
>>> +        len += strlen(reg) + 1;
>>> +        i++;
>>> +
>>> +    } while (len < size);
>>> +
>>> +    adev->n_regs = i;
>>> +
>>> +    return size;
>>> +
>>> +failed:
>>> +    mutex_lock(&adev->reset_dump_mutex);
>>> +    kfree(adev->reset_dump_reg_list);
>>> +    adev->reset_dump_reg_list = NULL;
>>> +    alloc_count = 0;
>>> +    adev->n_regs = 0;
>>> +    mutex_unlock(&adev->reset_dump_mutex);
>>> +    return -EFAULT;
>>> +}
>>> +
>>> +
>>> +
>>> +static const struct file_operations amdgpu_reset_dump_register_list = {
>>> +    .owner = THIS_MODULE,
>>> +    .read = amdgpu_reset_dump_register_list_read,
>>> +    .write = amdgpu_reset_dump_register_list_write,
>>> +    .llseek = default_llseek
>>> +};
>>> +
>>>   int amdgpu_debugfs_init(struct amdgpu_device *adev)
>>>   {
>>>       struct dentry *root = adev_to_drm(adev)->primary->debugfs_root;
>>> @@ -1618,6 +1710,7 @@ int amdgpu_debugfs_init(struct amdgpu_device 
>>> *adev)
>>>       if (!debugfs_initialized())
>>>           return 0;
>>>   +    mutex_init(&adev->reset_dump_mutex);
>>>       ent = debugfs_create_file("amdgpu_preempt_ib", 0600, root, adev,
>>>                     &fops_ib_preempt);
>>>       if (IS_ERR(ent)) {
>>> @@ -1672,6 +1765,8 @@ int amdgpu_debugfs_init(struct amdgpu_device 
>>> *adev)
>>>                   &amdgpu_debugfs_test_ib_fops);
>>>       debugfs_create_file("amdgpu_vm_info", 0444, root, adev,
>>>                   &amdgpu_debugfs_vm_info_fops);
>>> +    debugfs_create_file("amdgpu_reset_dump_register_list", 0644, 
>>> root, adev,
>>> +                &amdgpu_reset_dump_register_list);
>>>         adev->debugfs_vbios_blob.data = adev->bios;
>>>       adev->debugfs_vbios_blob.size = adev->bios_size;
>>>
